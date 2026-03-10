Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DD3EE1DC;
	Tue, 10 Mar 2026 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178215; cv=fail; b=XCRwerYd1rt0/g6jzvr7jXLMkg34zunMy+dhYZ+fkrNfiVKS1Pdx0Hm3XOG05UuNz4OV4KAZQKxNxiz0R+n7/7O5AoKr+j1twdVcu5hIZIlj+pj5I5/QOoWe5JeWCW13Dp8OE+6Jx/GIx72tqC4T1o52HOSKvLz3hmhVdKtUFzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178215; c=relaxed/simple;
	bh=xg2woXD9A/mkC5UMf/2awqyrHP5agxhCONLnPsqtulA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=N8bdnlf2SJtuFkmvdFfAR7CTOF3O+JDJOCrLYaIqc4Ngj9Yf3uUOmOjpCi7k1mv4ZyO5yMKxBifV39q1MRF+o2ZUq3SEz0VXBTdG64mjtiw9CRLE8/CTXtmy1bFNThbq2XruWRys9ITFlhxBQqrnTfz70RFNOlJFuJV9ig31yO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsRvJ45E; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsRvJ45E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACe2td1888503;
	Tue, 10 Mar 2026 21:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=xg2woXD9A/mkC5UMf/2awqyrHP5agxhCONLnPsqtulA=; b=hsRvJ45E
	jAyLDKxbRMBwx1Pm7lq00QlrViLQwOPWalUyHAtvqM2nBEtfniu7QrBKx6Omrp/q
	PUtThtaUM9pwD1EjFqspAowq3kedIs/itW50JJru87HpRwgzFKA1nIcmxVDoNEai
	6OSYWKVgPYthrwH+wkKQ/LVOdMM+Ol4amQlD8+2i3mFMmTdnbu9hupKmlyR48szH
	V0zYS19T8wonURN6WM12mUWuKT94pxQVlzoTvOef1uSD0epFWxZso7az0qSTtqeL
	6jJF4k131td+mL+6hOVViFJf3OSvTfz6txvet4uzn+omA++t+XGy6vCeSdClh1oF
	mhVmnX00pMSSBw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mmm4g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 21:29:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9Yh8N5GN2UVIJnak6r/qRKGonkDrxcI/qxGO/GVTAefZrkmIR0obAifP2p7ppdqdrLuogDrTFCJv3fh6AxKDUMGLLAMV/Qe+mAwdEuTEjwwKZac0m2G6YlCQYhsgmWcgosq+C8dmGvkahPOrFQYar3FxNp8B532FrVlNVtfYvTVdu5DM/maffq0Pl9YtH5Duq4uuHRex4ibtp1hwm6IMXbBK9tVddOK3KQoaNUG5YchJG0jA6Q1kQO1ep+KrE7W0FoX/BtwLHfzbRmztV8VFigvulR54qZIifbuj28XSphjjnHZFWDecYIp0yj9/5j9tUvkoUo7HAvJhNr1B/npGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg2woXD9A/mkC5UMf/2awqyrHP5agxhCONLnPsqtulA=;
 b=IIkTuRZSEB+VALMHHPEURZjcZ3FF9Qzf3cp4sEKuWdtuipSjucKzD9Rqm9uK4gnPNvHwH+V2sBmBzgP9wq9Q33qkHC40afA31ohuyGhO7uT4VZjwi1Q2b3yOqIndW+S5ltWnduKwLRrEVl7VeMUv1iOFeLVUHOIEFxR1AdVwVORz6fAIjExlVglqAG6Kp0KQ4ppf5txIvZY552pUKygHRrpdqFIB+r8X+s9b1LQJZQTYIf6xl+gbSe21Vb9AjbkqSD2/osvBxq9eQdPk1MzJ1j2b6X4lXVSf2Wnu4DejeGlscsWVwGFo6zMpN37P+pYTrkoEmKKMk2w/iFfHQHP5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5107.namprd15.prod.outlook.com (2603:10b6:a03:3ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:29:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Tue, 10 Mar 2026
 21:29:55 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
Thread-Index: AQHcsHreenkNfX7Dv0CuxpVwZ+slm7WoSRwA
Date: Tue, 10 Mar 2026 21:29:55 +0000
Message-ID: <03095fe969f9bf444629adeaaa996d60cd666d0a.camel@ibm.com>
References: <20260310000826.242674-1-contact@gvernon.com>
	 <57f080c6-a02e-4308-80e9-523bc757cc73@I-love.SAKURA.ne.jp>
In-Reply-To: <57f080c6-a02e-4308-80e9-523bc757cc73@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5107:EE_
x-ms-office365-filtering-correlation-id: d7ded227-4825-47b7-684b-08de7eec2c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 KPx1pqS36WA4fZCYmXpLi1zkRawjLJJT4nxML/bXS+ofGwNvuZFhTnOrKweHkA/00S/mZ5dW+K1fIOk3svojL8ssCO7KgCf8pkBJt/ouKpdIGjsy3VNAOhjCMdYN00Nk4rAFY/zwoEEJBFym5lGFIlgIL5PgvTwvuhgEYN8DC6XSv1b9Qg0Buy0XWefelQhf0rjjzyVDgUKLEbwzEa8ZCR9Snug4zq9eyKAKtDU7VuB7aaf9kpO+h7jq0nCNZlQu/F0xsfFNluQ5S0XvmWY37SP45qh8DeCEC5pfhIeVDQ2xv9dnXhwmduJxAvUZKMqq5ODgLx21Z8xeesN7cQiCI2OmksGrVvpkG/8kauwXlhxVVq601hYTLSMmsGdkSJ2guksTpX/qU7llPSJFDVKNBSr3HG7fajqjii7/oUOP0O1OkhZ47wF1ztfc75s49tk6hV9v1IGoDzXvTagTi5AUm3W/xhXi9PEyXgCf/h3bm9t/4tA7k1QlKUZg5F6caejPziYnroFDnVErjwujYKWmxBsu27uSA7eH9F/60sr3YlhZWqTVlicqROECotJi+6QhQZlpLNNp5miPN4cz2OVjvEQw66tht0ZUh7kvYS35j80fkrZbFM16JQk//ztt19EphCGPT1jcnf5T0UXK2+LsPzSXvojvL0MwF0wFA4CZl3g4Ae6ZDDsyJJHvzz0xlh8lIrXlLfPsnR0OHJK1Ur9rlL5w/bbM6kQvFqlLlyKqzgK7NcLHm8tyi2tClkRd5CBEun+KbESBxcUvQ6Yf6bmB9kPj3dv2ntKOUwMvB3Nfnmk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REtYZGo1NWlGVFVMeXAvaXBYQ1BnRnRtdmNOOVdhTnh0dHZHend6MTJBRjQw?=
 =?utf-8?B?TVdVeVcyYTNkRmlIN09XZ2pqSmMzWWJZbmI3N0djMElUQWFtT2FROG45TUt4?=
 =?utf-8?B?YjlVNTFWUkF3eHRvZU9OLzFDa0RKRFlBYmQrNGFHYVBhQXUyeHZEQjNiSWFK?=
 =?utf-8?B?eW43R2JKM2p2WWFtSDZZZEJ4K0ZCbU8wMDZQeC9oc1loM3k0MHBjcGpTM2FK?=
 =?utf-8?B?UWRXcmMzbTRlNHlYeXVTb0JsQlhIaXBSOWJiLzRJNVd5ZmRFVHN0d1dEYVFs?=
 =?utf-8?B?L0lleWd6Q3RiZkJCK1lPbjR1OWJmUTJ5bndtUjQwZjFOcXhwbVRuTW1lTDZi?=
 =?utf-8?B?MkVNbldXOXZwcjJHRTRUZmFvT0VyUTFidDBRT1RzTHNaN2pBNWt4WXdpbXp5?=
 =?utf-8?B?elprbEwwbXc5WjB0VDFJeTk2SWFwVG8xcmo2UGNqUXQ1ckg4dUtEQ0Z4Y25R?=
 =?utf-8?B?blZVSmp3Vm1KUUp6TXpqUGp4anBiZDdtc25oc0UxY1FUR3Q2NFBMU01GWm1B?=
 =?utf-8?B?UXRLMGtyUFlKK3V5RnVrQ0d3NkNwdGpxNllobGQ5ZE5rVHUra3hvcmhUaW02?=
 =?utf-8?B?Szh0TFphMzZueFEyRndLY0xNZnFwRVBNVVZuQzA2U1lxWUFKS0xIS1YxaWpK?=
 =?utf-8?B?dGNmNklkdW54T1FuY1doRmtvYzlsK25BdnpqV3Yxc25RMkUxZDBCYzVzakxh?=
 =?utf-8?B?N2pxODhGVWtWWlIxdTNtSUdGMGpxUkNOSkJDTmVmYW5oYzc2V2hSVERiMTBJ?=
 =?utf-8?B?V2I4S25MVDJGM2lZZ29VUEdhVTJyZHVpamFQUXdvYWF5eXhVeXlFM2pvam9E?=
 =?utf-8?B?dFpLZnFWUEx1TFUxdlh4dUtmbEJQdmk3TE1sbW04RlVzamtRd1JUWkN4UEZG?=
 =?utf-8?B?cTJYZ2hKN3ZKLyt4aFNuZ3ljR3d0Rzc1d0NQNFhqSis4VzY2WmhDcXlhdUM0?=
 =?utf-8?B?RklVUVlFR0ZDenppbDNWeHNFNUs5MU15QkxkbnB3OHR1WUJobVhVbUdSNVBp?=
 =?utf-8?B?Rk9ib2o1NVE0S3hhNURwY0pBK09VcTdobm51a3Bjb05oMWJmM2Jha2twNklM?=
 =?utf-8?B?dUdoUFFwR1dXbExzMW5SWU5sMDVBbGpaNEtSQ3d0dDIvNU5qY0M5Nzd1RDE5?=
 =?utf-8?B?cVRDQlhnRmYxaGxkK3VWdVpYWWF1K1h1bWVJUHNuakpoRDZNUGlxdFBPVHdS?=
 =?utf-8?B?K2tBQmtyeDZHdDJFMWNYQ0p4T2taOTg2a1E1NXJXcDc0S3RzVFIreVg5c2ZT?=
 =?utf-8?B?NHVUTmRTcDVvdk5LMW1WUEZ4OFVGTjRNMUVadW10bXZ5dWhNVVdKV1ptM3cx?=
 =?utf-8?B?N2lYb0h3RThxUmVlSlgyZ0FtYlVuOHV3SSs0V2Y1T1BMZ0tjSjJZYmg3cW9u?=
 =?utf-8?B?UEZJcnllTFphMVZTeXdmS2VEblEvTjYxVWxOVStwbVhGWUx4WWFxMWhEVEI2?=
 =?utf-8?B?NEp1emxYN3QrbWw1aU0yYjJMZlRkSFpVN2pBNkhMQlROMzc0SGR0V2tTcjkv?=
 =?utf-8?B?SmJabjJ2UzNsbE5OUWFnUzJLb0VsYjRoaDRFRmlTb3B2dzEydmU0aURPWkll?=
 =?utf-8?B?bjV6bUtoLy9wbzF5UW8xQjdLY0U2WFc3TXJyNVZHeCsrcDVEVHZONE1tOCtZ?=
 =?utf-8?B?bGZNdmVOMFdROXR6dGVBNXlralNORXAzdXdocFh5L0NUc0tYWE9tQVh5amIx?=
 =?utf-8?B?YlB0eVo4ZkhRSFIxU295MUREVXhTdWxyMGRGV3RPQmpXZXF4cCtMR3RWRDVM?=
 =?utf-8?B?N0d0cDNhTEZHQ2FKTFNadzZBbkloRVJialltUGxKaHVPNGxpZUhiMnBVbVBJ?=
 =?utf-8?B?TzNLb25WdUNVeEIxSlZQK2ExaGNZZjlGU28xbm84T2I5a0JPZHBZUjBoYTNL?=
 =?utf-8?B?QXJSd1lqOEJmSzBMNmRNU254R1FIc0tyUHpOS01oM0x3ZWFqNkc4NDhDNW1Q?=
 =?utf-8?B?UWdubWxTbUdBU3hML3duWktpVXFRNVFsOGJ5ZDVLRXQzandaNTQ0TzhFdmpF?=
 =?utf-8?B?Z28yR3pPeTA2c1ZvQ1YyME5yVFhGNnFPRlhJTlkxNVBUeTFWWHV4d0REUnNZ?=
 =?utf-8?B?blBZNE9KcFZSU0dTU2FybjZPVVJZZWlxM2RHL0RONWk2d25MWS84ei85TUd4?=
 =?utf-8?B?L0Jyazc0YVJ0WDRkb1JBQVBndGNqbm5NOFoyUHNYM2VQbHAxb0d6T2NUTEI3?=
 =?utf-8?B?L04yNzkrVlNROE41akEwNVJaTjdKKzFyaUtseTU5ZjVRSWxsVGg5VnRrSFZU?=
 =?utf-8?B?VlZYN1daRmtkQ0RMYm14MTc4M0NCWkJ4NFRCZmRra3BTSEVzVmxlaEpLelEr?=
 =?utf-8?B?RFdEb3Q2T2V6RkJDRE9rbkdMZCs4Q3JGRjJ5Q2tJN2VaNVRCcjh0ajlVWFRW?=
 =?utf-8?Q?ltFwnSvX718gkIaXq+Tukh5/jbB51c7C07yeJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB065C4036F964CAABDDCA8AE30D1D6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mi8kWuED90OwRiZ0hMzt5bBFrAuBZJKikbc/W5hDpMJ73lJXTWDJOMy3i5eZhcLABtoTW0YgwtC5AsKfpko/BjaEt2yp63NbhMEmYfO8MKWzZRueq9a1hbLAVQIdYkaSoaZAOp3syyO3C+m6N26Xe79ztuHxc+q+FXB9BenO1Mk2baJgOpWSaunJAG1UssrQSoXD0gi9my3ot1agAbq2yjv985H138GluoXj4wOJCz0K0Qk5Qf8R+0wQwdwUSDxofkqAFOjvdTUcLJ56qQzAWc3fX4QP6sXbFxIBV97qt94ljyM6lqqh7nxbOevSOclRszHZsFi69D6Nf3M/auK04w==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ded227-4825-47b7-684b-08de7eec2c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 21:29:55.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: No2hWyz7zj3vtCH57C6ONn64KaGb1FzwUZwSEp1X1aNu5Oyta1TYiQdio+Ke2gAvrMWMoEf5V9Ebp+s8vU6O+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5107
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b08d55 cx=c_pps
 a=AQ8jqBFaYtg5UXnSSWtk/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r5AK3RBNvuTY9zqc-bEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3OSBTYWx0ZWRfXxNhudEAYCpuA
 wu/zDaW2T9kWpfKOMzGrxxy9jsJT6/FkaukMGK3QeNL9lXMsHmCeenlx9kr5ehb4C2xdUEMZGE7
 HM3hLc2t7qgFkeUjSU/MZvPJqcOFimQryRRnjc9YCMuHkRF3bX+++vwRpy+WmDhGvE+pW55yaQW
 hoHNdjDe7CSVovQnkrUBmCwJyA0C0VQgfqa4BZHxk8D0bQbI1AQVb6zEBkAec9h6/JzmyaCcqDF
 do/8LEUAYKBBGpsbIP0TGCmWORNwsg3UtK5TxfZWHKL2LuDxb5rl1xNF4R6hT3oMcDsURcyhP1T
 xbDZ8w0bTmqpD4t+X+a+yU2fJWeYxEtxvoQkLa59Jl2VBRBFeZ3HmQaUPwBPUgG+HTlzO8DjAfE
 VUEP/hvtHut6Q+NNc8w/KK/G55KWOaaiZtF6r65FKJeNgto0zkHljGAkIMqfzgCjIRoDjJfRDCv
 dXVh/IHDa4BWZbOVysQ==
X-Proofpoint-GUID: 1dxDy1neEDOE8cXwe_HSgBixlNenHXzz
X-Proofpoint-ORIG-GUID: 1dxDy1neEDOE8cXwe_HSgBixlNenHXzz
Subject: RE: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100179

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDE5OjQxICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDMvMTAgOTowOCwgR2VvcmdlIEFudGhvbnkgVmVybm9uIHdyb3RlOg0KPiA+IC0g
UmVtb3ZlIFRldHN1bydzIGFkZGl0aW9uYWwgc3VwZXJibG9jayBjaGVjayBmcm9tIHBhdGNoIHNl
cmllcw0KPiANCj4gV2h5IGRvIHdlIHdhbnQgdG8gbWFrZSBtb3VudCgpIHN1Y2NlZWQgZm9yIENO
SURzIG90aGVyIHRoYW4gSEZTX1JPT1RfQ05JRCA/DQo+IA0KPiAgIDAgPT4gRUlOVkFMDQo+ICAg
SEZTX0VYVF9DTklEID0+IEVOT1RESVINCj4gICBIRlNfQ0FUX0NOSUQgPT4gRU5PVERJUg0KPiAg
IEFsbCBvdGhlcnMgPT4gc3VjY2VlZA0KPiANCj4gRnV6emluZyBhZ2FpbnN0IHVucmVhZGFibGUg
cm9vdCBkaXJlY3RvcnkgaXMgbm90IHVzZWZ1bC4NCj4gDQoNClRoZSBoZnNfZmlsbF9zdXBlcigp
IGhhcyBub3QgYmVlbiBtb2RpZmllZCBhcyBpdCB3YXMgZGlzY3Vzc2VkLg0KDQpUaGFua3MsDQpT
bGF2YS4NCg==
