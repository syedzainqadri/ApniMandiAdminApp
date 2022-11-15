import 'package:apni_mandi_admin/models/mandilist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_manager.dart';

class MandiDetails extends StatefulWidget {
  final MandiListModel mandiDetails;
  const MandiDetails({Key? key, required this.mandiDetails}) : super(key: key);

  @override
  State<MandiDetails> createState() => _MandiDetailsState();
}

class _MandiDetailsState extends State<MandiDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          title: Container(
              margin: EdgeInsets.only(left: 60), child: Text('Mandi Details')),
        ),
        body: widget.mandiDetails != null
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            'Mandi Name:',
                            style:
                                TextStyle(fontFamily: 'meidum', fontSize: 16),
                          )),
                          Text(
                            widget.mandiDetails.mandiName.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'regular',
                                color: ColorManager.primaryColor),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              'Province Id:',
                              style:
                                  TextStyle(fontFamily: 'meidum', fontSize: 16),
                            )),
                            Text(
                              widget.mandiDetails.provinceId.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'regular',
                                  color: ColorManager.primaryColor),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              'City Id:',
                              style:
                                  TextStyle(fontFamily: 'meidum', fontSize: 16),
                            )),
                            Text(
                              widget.mandiDetails.cityId.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'regular',
                                  color: ColorManager.primaryColor),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              'District Id:',
                              style:
                                  TextStyle(fontFamily: 'meidum', fontSize: 16),
                            )),
                            Text(
                              widget.mandiDetails.districtId.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'regular',
                                  color: ColorManager.primaryColor),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              'Mandi Id:',
                              style:
                                  TextStyle(fontFamily: 'meidum', fontSize: 16),
                            )),
                            Text(
                              widget.mandiDetails.id.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'regular',
                                  color: ColorManager.primaryColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container());
  }
}
