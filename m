Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540859;
	b=dv6Qi75oqolIIr4c7Tzf4q46BpIrucXLADYYasaJhP0794rud0kspYNDTGRF/ZQ0J3UV
	 B0sApDW0kRXEdmjziVG4Lvzr4rUGGpq9euTduaYcGGhzTeGNYTm9tAq+cUwaBCzLIaWwU
	 /wtuyc97a3fZ33HmWp9dUcOj8EspixFmvaYPprguGM7I+7Y98gBxztaZmVTXjLIxW0bWC
	 pg1vynS9s+WCCy16JG/IP7sSdOjq/gPZ4mQbhtbv3LzcWJc/TOC0Fmme+iRng8OaQpG9c
	 5W3mppDfIAxReVDnLhOvfGr6qkzyDHecKM7J92oXJqaa5eEP4cFmLJllFOZERy14bPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540859;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6nvi9/4QZZEoVaSKSDeC+9ZEnh/wuzgk89De54SxmEw=;
	b=Av4reQg0/HhjRPATioX8UTorFHlOhXitQfz5+VicY1dt+lfcjpmso6L9460viVDfTrv6
	 JHHLskCZYAXG51xZ8G9tKHpdRtFOPpN1ta9Q+9GytNVvjdlGy7hidVuXwfsYhZ4Sxy3MB
	 SsS6uzFyIlvXoCyvGpSGJU9BayjbGUZx8COXTZnBv+R5LKUDr+N2HqfBrZ4uoL3pAz6QM
	 m63CUm1eDPI6ki+FSTgILTfRwNxvBXYuXdNdidVo8IZluLDjEhzzNCkTZJd3j0JD4BgmO
	 IqmZhlvxmtXcYqDG1Y7hD5/eHa5SvnRSUq6NqUGdNrSl46uqLg/wiT0qWpnryYH2gjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XJT99Pmm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.66
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013066.outbound.protection.outlook.com [52.103.20.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAF606A323;
	Tue, 24 Nov 2026 17:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EFAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XJT99Pmm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0kGPsFyrslhDd/MNB7fgehUhOeQ50jSap01fZ3eILrewNwbtLDHniedx2sxQtsAhEQqrgRjs0SfTA0XoF9xTdvS1XaqxhG4H0KPhVYRT/Y7BLHvo+rO5bA+k49/fCrPGmUqO3njVaij1Oltd4m6bivsp8Arvoq3chrgNLCmB8AhmMA+7YlgjZ+UFg+i/O8TsgapxgReam3gEsgpdKgXlBKnowReAptCNg6LwhhOSQgpFXmT4uBHHyVNRWqfL7e+kdu3y/UAKXIsYOYfQwR8WIZVJIC1XrCjDx4NLonsMgr5jryuHSPJoopcbggwJ+Z1Vk5ZnxZsdc+OI8zsxEUGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nvi9/4QZZEoVaSKSDeC+9ZEnh/wuzgk89De54SxmEw=;
 b=WvS+K1fwgWkIqUsBQRueBu9zfh/YKYHUlFjJWMMOqzG2tmv2mZsLFNWKYvm2wSuefhVNkX2oRwH917Z4zkWXyfn0q2mKG/Ycb4kC9dKHAnfFtH710BXPzelhLcccuEqObbxj/3ZNkN9BffFj+Tdiy8kwIBuGyAWNf6FA+bJw1lywwMNCvx91/UZTVXJ1FOZIZRpmCeNqjnX4SPgDnCz6WlrvpktY4Q1lHFoDNNCZ1cGimKed5CGQJgaeaQQxtOp5qd9RQEN/15uF+0yQ/4C9do3LfhwVQZV+wJDml3bhy9wIYs4KKkfMKYiPPMyZk6Eyli+QNdBATe3DdhQ+rWCPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nvi9/4QZZEoVaSKSDeC+9ZEnh/wuzgk89De54SxmEw=;
 b=XJT99PmmXmpTk1vUIxNl/T+VkeTGi0LUp/fIT4d9ytNFutrX4Ahnx+92krBNxohbux7giICK89RAYnM6MikSk4hdlOXXX9+0yALozwHIrygyCuhSkQ6A2Dnm/xSq/RHUYjHBDWUNndPyEJKM3VDb0rQcVr9ANy392d7bYOYV1twnMUPgWhMwZRnmTU0xclZp+TFEPZrM8CiRNnfhFV+Ohzd63rD+7NeySkw+bis11UEe1BWmhiIkzktxHAzp7/BsBiIjqGBv/hUEWojSpKUwWW3iR0h5thshQXEz7iKlyn0LCdOiqhlJ9Z0sxnrDrg/rsSJgOJaj8x4r+rPlRkprUg==
Received: from DM4PR15MB6276.namprd15.prod.outlook.com (2603:10b6:8:185::22)
 by PH5PR15MB7011.namprd15.prod.outlook.com (2603:10b6:510:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 17:20:55 +0000
Received: from DM4PR15MB6276.namprd15.prod.outlook.com
 ([fe80::cfd2:b16d:7d13:943f]) by DM4PR15MB6276.namprd15.prod.outlook.com
 ([fe80::cfd2:b16d:7d13:943f%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 17:20:55 +0000
From: theBIT5 x3zk <x3zk@outlook.com>
To: liubaolin <liubaolin12138@163.com>, Namjae Jeon <linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open
 list:NTFS FILESYSTEM" <ntfs@lists.linux.dev>, Hyunchul Lee
	<hyc.lee@gmail.com>, Baolin Liu <liubaolin@kylinos.cn>
Subject: RE: ntfs: deleting $Extend breaks subsequent mount
Thread-Topic: ntfs: deleting $Extend breaks subsequent mount
Thread-Index: AQHde4R8xv4yfu0CbUa8W2Kg8yjy6rc8zkBigACqwrU=
Date: Tue, 24 Nov 2026 17:20:55 +0000
Message-ID:
 <DM4PR15MB6276AEA50787E7D27EF8590B86442@DM4PR15MB6276.namprd15.prod.outlook.com>
References:
 <DM4PR15MB6276A5C442568B4C7E604AA386452@DM4PR15MB6276.namprd15.prod.outlook.com>
 <CAKYAXd-MHxzjvc20J-x4VYBnuk3sVpzmHo+zrHb8n3nx8Aav6g@mail.gmail.com>
 <a2f75e81-b012-4bb1-8885-a2ed310fa988@163.com>
In-Reply-To: <a2f75e81-b012-4bb1-8885-a2ed310fa988@163.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR15MB6276:EE_|PH5PR15MB7011:EE_
x-ms-office365-filtering-correlation-id: 90f22960-0548-48c0-378a-08df4a4f4c3a
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRiwd6S1M4PEGmQhYn5Dp9EgmMyEeDxJ+jj7BHWTshM77SauXHbPK3PgpEyLvDONxtOec511N/7vmntISsDbdB4m7zmu3R4mzCOFcc7e4goTRzTyqmLAWvGEH9F2wco3y3JfUKOSh+wCr4Bn9CXm2CtwvbQTwZiAzJgOnxyGBUIO3VS6fuoMuzuc66Gg7xOvxVgu5T4onPplCdFgHYDslGLEXRkG7aM9NXa4AXdlDL1ViHegBIPBgV8TkR8wNAFs/uaknGO461lfBsOWevYUqR+60wOxqp+zNuh2tobkARWTXJMmriO2M8f3RSkH6NT1VJp5AnqBLk4m8PuKRih+dZUXOOXP4kRm5m0YEg/ZP1wvJLHXzTzlMwc11L7hJ+pMPzJYnqKpmP5dB1zSRe32Pnc8VAwW22Cr9teboJRy9vW0a5FLifW5glSmZ3e2a89OFJtmSUatflqon+oMB17L1LDXLe1AxjYaWLLgjL8h/wHxIutn1qRWCLWQtorsfQgPMN/gntwbaquQDd9PXyNx/dd76h6Jdftoc7Izs7wWuhLoag5ZxmVLlxlVTj1OxAaZuIarYgxe8R9BvjLEnMyjfNHYYXNzDXdus3xjLCw5bMqWSbCCvIfi3EJav4ulYdwSSkx8gTvCSpPOJB4DG3WO4iR5kXMzKLSwczARQ6hysJbsd/7IDBMCerv389SFws7/gU8C05JReW9u9uVAi1HNA1o3revfU6QjubsTJpCkJias4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37102599003|8062599012|19110799012|8060799015|15080799012|15030799006|31061999003|12121999013|45011099003|4140399003|6050399003|26104999009|440099028|102099032|3412199025|3430499035|52005399003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGI3N2Q2a1VVS2ZmVHBsYXE2eVordHNaei8vMzJOMlVpV0N4ZlFRcHNmNm1s?=
 =?utf-8?B?OVBzdGlOcWw2R0Y5OUxBMUh0YXRXTU4yTDVhaUdsM25HcEpkK2k5TDRrSmJJ?=
 =?utf-8?B?TTFXeVFuNzF5RG9hWWMyQ0dMRUtwQmVENUtQWmNxV2RpMDc2R1Zla2dHaVEy?=
 =?utf-8?B?Nit1cy90WXNkZzBubHNsREdWbHdmZThhMWJIU2ZJSGxMU1dodmpsc0x6N2tw?=
 =?utf-8?B?K1dSc3FJZjMzMFVUZXRQbjlZbTAyd3FjN3hpa2R3NDZSZmZBV1JvUytoMmdE?=
 =?utf-8?B?LzJqNEd3TGMvYlJWVDB5YjNBaWR1ZEVEeHpoVjM1aEt2QmlXSm50aEdMR05L?=
 =?utf-8?B?MFZhS0ZnR1dJVyt5UTlZNzZ3Vy9GMm5zdnVuNFNDMU4zSHJEaE5UbDVYQ3RI?=
 =?utf-8?B?NkZiWEhxeTBvRmVCTWhvUWJkNFB6cWNMaHcza0txZG9RRXpteUhiRFBRL1Uw?=
 =?utf-8?B?U0tmcndySTJSRXkvNm1OOEZsVUtLVk1IeCtSS1ZnYkI4STdGdFB1SGl0VElC?=
 =?utf-8?B?dlQ1cDBCTlRyQnNPUFRkRXNHeURiQk9HMHdmMWVLNHZxTzg0WGU4dzlLYXlK?=
 =?utf-8?B?MFppWGo3eUt0SHJuL0c2SkFwN1lIZGdDZEFjUWJFMmc0SEpDUDU1cU1YMzhH?=
 =?utf-8?B?bzNRaXZOZjEvMFBqZ1FKMEdEVllxcDh3SVFRZTYxRnBiN1NWNnFUZk9vN0NI?=
 =?utf-8?B?Sk8xM0krTk9EV0FMWmJPUVVGR0VBMmd6aG5pWStZa1hQbFFhWHRxdmFDS3JT?=
 =?utf-8?B?N1lmc0JwY2R2ZDRORkdBS1RQRWNzN2treW5iTTdaY3QzODlJc2JEandlOGtY?=
 =?utf-8?B?ZmZNVjZkN0dsZjJ4SlU5TWVYUnozRFRVM3A5ZGFNVmtxYVBJcDRETGN2SEJw?=
 =?utf-8?B?dEtXbVBYeTdiN2kzSFZJWWlOM3ZGU3RDNms0elBFSEsyMzI2eDY5Z21HMGZh?=
 =?utf-8?B?aThFQllnZVBadm5Cby80V1ZTMkNQTWpTNTVGdGZ3RnFHelVZdGNETzNoNWh5?=
 =?utf-8?B?clNmd0lnS0ZBU1VJVFFpZlFnZDRXQVRqem93UFFhdjBZRFNHREtBSXIvbEZF?=
 =?utf-8?B?MjExN1FsYWRwajF6ZU9GVFd2MVdiM3BuV1FZR2hoNjNDWmt4SUdITXRQTC9J?=
 =?utf-8?B?WlVvSklzbkYrUWd3OEh6MHphUnpwL0RwRTRwd01nUnJFZkpWbTFLcDN1SEIy?=
 =?utf-8?B?alhCZWxlNVY2ODEzellwdzdkTmlYM0x2OUFyTmFVZ281VGc2bUk1TGFNbGRB?=
 =?utf-8?B?NHZ4WGZSNU81V2dmN2kvOHpsSW1pU0t6azNQYituYzJ1Ym9RTXRPRTNqVTcz?=
 =?utf-8?B?WnFzL1RzVXhCYTlQNW1iMU04MG94RWRjVkcxak9vOEwwbEVBOHM1dXhRSC9C?=
 =?utf-8?B?anNHSFBpZzFnUnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEJIVVVyM0h2WmQ0cTN5UUNCT1Z5cjQrM0pEeXMwbGJxV2xDN3MxakNnUzJm?=
 =?utf-8?B?RmlwRFE2VitKWkNHeGwxVk5obC80MjJ0MFJoYXBBMHNYRjA2c21ubHNXZVBR?=
 =?utf-8?B?cVRIK3c1YkxsY3FzQ0FLUk9CYTBKZmZyUkdXMXpuTktpSmpmdTB3SXVHUEE1?=
 =?utf-8?B?UHEydEt6ZERXd1VrVy8wc01KQnJVMFdRM1dHVUt3bVl4dXhFaEFhUi9vbkM2?=
 =?utf-8?B?eER6RGdlMlpBZXVFQ1A5akdqenc2UzhLK284Y0FjN0d1U0FtbDNvekNJTnA1?=
 =?utf-8?B?dmN4WnpONjhjWWR1TzVCYkhWTXYvcnVPSHZJUllGSVFuaEd1RHhiREp2WjVh?=
 =?utf-8?B?VTZlOThjOVA4ZUNaRHIwRlNXNU5QWkV3VkZFdC9ZWFFiN3FGSzdBamJZbUhk?=
 =?utf-8?B?KzBMVUxSdzBlZDJFRDI5VFVMQ1ZTUllBQ3l0UC9EUHFwWTFWeDFXNlRJbk8r?=
 =?utf-8?B?blVFanlDQTd0ZU9kYmR4TnVKaWpqc3BuekRvNlRFTS9uelE2MGpkbUQzQ0lv?=
 =?utf-8?B?SlhHeFpIR3BpK0RxMHNtMUc4V25BRE9qWHRhWEUxaW52WDRabjM0V0YzYklv?=
 =?utf-8?B?RjBrZmlpTmFiOG56TzlNVUNQZmpPd2phUS9WY3N3SW1pZ21SV1I5cU1BcUg4?=
 =?utf-8?B?dk1YNm1TQlZ3WXhqYkFsUnNOOGtRdzNPa2s1U093MlJ5bnhsMnRsejZIeU1T?=
 =?utf-8?B?SG1DSkhhQ2drZkkxWDdwd1hqRGRLb2dieXVRSHZpZ2pMNFM5d3IrQXRSNFlh?=
 =?utf-8?B?S01pUS96bWxuYnZRbW5wU1V3REEzbFpndklrdGZjSUlteVdoNGxxN0tRdGF6?=
 =?utf-8?B?dDU4OUFVa05RSzYzQSs5SXNsSmdmV2hVSXNyb3Y3NklWa0QxNlQ3Z1Y4cXFE?=
 =?utf-8?B?OE9IYStqVndFdGJDKzEwUWg5bFJaVUpvclJic0x6U09oODdQcFVMTncxZUdX?=
 =?utf-8?B?M3lxZWk5QmpEY0plU1F1ekh5TnYvUS9TZFMzcU9MN0xzMnNldXVyNkM0UmV1?=
 =?utf-8?B?ZzBwckwrTzJaNTl2bml1eVowUnZ5SWpLbHZtc2hHUXcrc0swSUE0MTRwWUlw?=
 =?utf-8?B?eFV3cjk2T2kxZ08zcXkwMjFzaGRZM21INE5aL3RSalEzZjBzczM2VEgwazJN?=
 =?utf-8?B?b3ZHRjYyUmdRclNTQ2E4cXdOQ1dOaWdoazYxbDRqSEFTeDMvWHgwUnFSTkF0?=
 =?utf-8?B?TEg4VXJMVkFVbys2RXQ1TTh6aHZ6bFprQlZNYWhKWmpOM2RyMGxXbDFjajVo?=
 =?utf-8?B?VUcydWxrUmhxWWxJVXpmcW9DNVFHZDB4cHd5T29PVFNIT1NBMy9BK3dHVWtL?=
 =?utf-8?B?T2VtMFBTeThGTWNqWGVLR3RDQ1l0eWRLdkNId1pYMWQ3ZkNpa2tjaVpWL2Mr?=
 =?utf-8?B?TkhVWkhWUEVWa1l0NkFRektQaTFZaGxMaEJxRVMrWUtqSGpGcVo0K05QajZJ?=
 =?utf-8?B?amJ4Z09sTGcvbUQwdXpiYWRMNlNtb2poU1VlSVdoU3Q5a2lFUzNUVmZkdFN5?=
 =?utf-8?B?eUh2UjVlQkFqc3lIeTd6alMxVXhwTCtYYW82Q3R2WDMwOWpGcTBYazlGVi8y?=
 =?utf-8?B?RDE2OGFHaFVXdEpjZ3QyWFBkODJGNm5rRDJDclh1RjA2aTA0SEJpSG1LQW5k?=
 =?utf-8?B?bWZpZ3BaZzBhRXI3YlgxNXdTYWNhamlmK0pRRll3RFdvWEVlY1kxSFloWURH?=
 =?utf-8?B?bXRINm5QVkgyMmRNVExjVFhsZTZUUHA1c2s0YWxib1VMdWRrMGRRTlRYMTEv?=
 =?utf-8?B?aXRyVDR1UUxGWXlwV3Y3ZkFvNVVoek4rMTRtcU51WElkK1BCeXlKVFVYMXND?=
 =?utf-8?Q?07Dgvxh+ckliPOrdM806a+piMpW3C+GpTLqrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB6276.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f22960-0548-48c0-378a-08df4a4f4c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 17:20:55.1465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR15MB7011

SGksDQoNCkJ1aWx0IDcuNC4wLXJjNCB3aXRoIGJvdGggcGF0Y2hlcyBhcHBsaWVkIGFuZCByYW4g
YmFzaWMgY2hlY2tzLg0KRGVsZXRpbmcgJyRFeHRlbmQnLCBjcmVhdGluZyBmaWxlcyBpbnNpZGUg
aXQsIGFuZCB3cml0aW5nIHRvIGl0cyBzeXN0ZW0NCmZpbGVzIG5vdyBhbGwgZmFpbCB3aXRoIE9w
ZXJhdGlvbiBub3QgcGVybWl0dGVkLCBhbmQgcmVtb3VudGluZyB3b3JrczoNCg0KIyBtb3VudCAt
dCBudGZzIC9yb290L250ZnMuaW1nIC9tbnQgLW8gbG9vcA0KIyBjZCAvbW50DQojIHJtIC1mciAn
JEV4dGVuZCcNCnJtOiBjYW5ub3QgcmVtb3ZlICckRXh0ZW5kLyRPYmpJZCc6IE9wZXJhdGlvbiBu
b3QgcGVybWl0dGVkDQpybTogY2Fubm90IHJlbW92ZSAnJEV4dGVuZC8kUXVvdGEnOiBPcGVyYXRp
b24gbm90IHBlcm1pdHRlZA0Kcm06IGNhbm5vdCByZW1vdmUgJyRFeHRlbmQvJFJlcGFyc2UnOiBP
cGVyYXRpb24gbm90IHBlcm1pdHRlZA0KIyBjZCAnJEV4dGVuZCcNCiMgdG91Y2ggZmlsZQ0KdG91
Y2g6IGNhbm5vdCB0b3VjaCAnZmlsZSc6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkDQojIGNhdCAv
ZGV2L251bGwgPiAnJE9iaklkJw0Kd2FybmluZzogQW4gZXJyb3Igb2NjdXJyZWQgd2hpbGUgcmVk
aXJlY3RpbmcgZmlsZSAnJE9iaklkJw0Kb3BlbjogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQNCiMg
Y2F0IC9kZXYvbnVsbCA+ICckUXVvdGEnDQp3YXJuaW5nOiBBbiBlcnJvciBvY2N1cnJlZCB3aGls
ZSByZWRpcmVjdGluZyBmaWxlICckUXVvdGEnDQpvcGVuOiBPcGVyYXRpb24gbm90IHBlcm1pdHRl
ZA0KIyBjYXQgL2Rldi9udWxsID4gJyRSZXBhcnNlJw0Kd2FybmluZzogQW4gZXJyb3Igb2NjdXJy
ZWQgd2hpbGUgcmVkaXJlY3RpbmcgZmlsZSAnJFJlcGFyc2UnDQpvcGVuOiBPcGVyYXRpb24gbm90
IHBlcm1pdHRlZA0KDQpUZXN0ZWQtYnk6IHRoZUJJVDUgeDN6ayA8eDN6a0BvdXRsb29rLmNvbT4N
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K0J7RgjogbGl1YmFv
bGluIDxsaXViYW9saW4xMjEzOEAxNjMuY29tPg0K0J7RgtC/0YDQsNCy0LvQtdC90L46IDI0INC9
0L7Rj9Cx0YDRjyAyMDI2INCzLiAxMDowOA0K0JrQvtC80YM6IE5hbWphZSBKZW9uOyB0aGVCSVQ1
IHgzemsNCtCa0L7Qv9C40Y86IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuIGxpc3Q6TlRGUyBGSUxFU1lTVEVNOyBIeXVuY2h1
bCBMZWU7IEJhb2xpbiBMaXUNCtCi0LXQvNCwOiBSZTogbnRmczogZGVsZXRpbmcgJEV4dGVuZCBi
cmVha3Mgc3Vic2VxdWVudCBtb3VudA0KDQoNCg0K5ZyoIDIwMjYvMTEvMjQgMDk6NDAsIE5hbWph
ZSBKZW9uIOWGmemBkzoNCj4gT24gVHVlLCBOb3YgMjQsIDIwMjYgYXQgNTowMeKAr0FNIHRoZUJJ
VDUgeDN6ayA8eDN6a0BvdXRsb29rLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSGksDQo+IEhpLA0KPj4N
Cj4+IFdhcyBtZXNzaW5nIGFyb3VuZCB3aXRoIHRoZSBuZXcgbnRmcyBkcml2ZXIgKGZzL250ZnMp
IG9uIDcuNC4wLXJjMy0xLW1haW5saW5lDQo+PiBhbmQgbm90aWNlZCB5b3UgY2FuIGp1c3Qgcm0g
LXJmICckRXh0ZW5kJyBldmVuIHdpdGhvdXQgc2hvd19zeXNfZmlsZXMuDQo+PiBBZnRlciB1bW91
bnQsIHRoZSBmaWxlc3lzdGVtIGZhaWxzIHRvIG1vdW50IGFnYWluLg0KPj4NCj4+IFN0ZXBzOg0K
Pj4NCj4+ICMgbW91bnQgLXQgbnRmcyAvcm9vdC9udGZzLmltZyAvbW50IC1vIGxvb3ANCj4+ICMg
Y2QgL21udA0KPj4gIyBscyAnJEV4dGVuZCcNCj4+ICckT2JqSWQnICAnJFF1b3RhJyAgJyRSZXBh
cnNlJw0KPj4gIyBybSAtcmYgJyRFeHRlbmQnDQo+PiAjIGNkIC8NCj4+ICMgdW1vdW50IC9tbnQN
Cj4+ICMgbW91bnQgLXQgbnRmcyAvcm9vdC9udGZzLmltZyAvbW50IC1vIGxvb3ANCj4+IG1vdW50
OiAvbW50OiB3cm9uZyBmcyB0eXBlLCBiYWQgb3B0aW9uLCBiYWQgc3VwZXJibG9jayBvbiAvZGV2
L2xvb3AwLA0KPj4gICAgICAgICBtaXNzaW5nIGNvZGVwYWdlIG9yIGhlbHBlciBwcm9ncmFtLCBv
ciBvdGhlciBlcnJvci4NCj4+DQo+PiBkbWVzZzoNCj4+IG50ZnM6IHZvbHVtZSB2ZXJzaW9uIDMu
MSwgZGV2IGxvb3AwLCBjbHVzdGVyIHNpemUgNDA5Ng0KPj4gbnRmczogKGRldmljZSBsb29wMCk6
IGxvYWRfc3lzdGVtX2ZpbGVzKCk6IEZhaWxlZCB0byBsb2FkICRFeHRlbmQuDQo+PiBudGZzOiAo
ZGV2aWNlIGxvb3AwKTogbnRmc19maWxsX3N1cGVyKCk6IEZhaWxlZCB0byBsb2FkIHN5c3RlbSBm
aWxlcyAoLTIyKS4NCj4gUGxlYXNlIGNoZWNrIHRoZSBhdHRhY2hlZCBwYXRjaC4NCj4gVGhhbmtz
IGZvciB0aGUgcmVwb3J0Lg0KDQpIaSBOYW1qYWUsDQogICBJIG5vdGljZWQgdGhhdCBOSW5vU2V0
RXh0ZW5kU3lzKCkgaXMgb25seSByZWFjaGVkIHdoZW4gbG9va2luZyB1cCB0aGUNCnVubmFtZWQg
JERBVEEgYXR0cmlidXRlIHJldHVybnMgLUVOT0VOVC4gQSBmaWxlIGRpcmVjdGx5IHVuZGVyICRF
eHRlbmQNCnRoYXQgaGFzIGFuIHVubmFtZWQgJERBVEEgYXR0cmlidXRlIHNraXBzIHRoaXMgcGF0
aCBhbmQgbmV2ZXIgZ2V0cw0KTklfRXh0ZW5kU3lzIHNldCwgbGVhdmluZyBpdCBtdXRhYmxlIHdp
dGhvdXQgc3lzX2ltbXV0YWJsZS4NCg0KICAgSSByZXByb2R1Y2VkIHRoaXMgd2l0aCB5b3VyIHBh
dGNoIGFwcGxpZWQsIHVzaW5nIGRlZmF1bHQgbW91bnQgb3B0aW9ucw0KYW5kIGEgc3ludGhldGlj
IE5URlMgaW1hZ2UgY29udGFpbmluZyBhIFNZU1RFTS1tYXJrZWQgZmlsZSB3aXRoIHVubmFtZWQN
CiREQVRBIGRpcmVjdGx5IHVuZGVyICRFeHRlbmQuIEFmdGVyIHJlbW91bnRpbmcsIHRoaXMgd3Jp
dGUgc3RpbGwgc3VjY2VlZHM6DQogICAgIGVjaG8gY2hhbmdlZCA+ICcvbW50LyRFeHRlbmQvcmV2
aWV3LWRhdGEnDQoNCiAgIENvdWxkIHdlIG1vdmUgdGhlIGRpcmVjdC1jaGlsZCBjbGFzc2lmaWNh
dGlvbiBpbnRvIHRoZSBjb21tb24NCmlub2RlLWxvYWRpbmcgcGF0aCwgc28gdGhhdCBzZXR0aW5n
IE5JX0V4dGVuZFN5cyBkb2VzIG5vdCBkZXBlbmQgb24NCndoZXRoZXIgdGhlIHVubmFtZWQgJERB
VEEgYXR0cmlidXRlIGV4aXN0cz8NCiAgIEkgdGVzdGVkIHRoZSBjaGFuZ2UgYmVsb3cgaW4gUUVN
VS4gVGhlIHdyaXRlIGFib3ZlIGlzIG5vdyByZWplY3RlZA0Kd2l0aCBFUEVSTSwgYW5kIG5vcm1h
bCBmaWxlLCBoYXJkLWxpbmssIHN5bWxpbmsgYW5kIHJlbW91bnQgY2hlY2tzIHBhc3MuDQoNClRo
YW5rcywNCkJhb2xpbg0KDQpZb3UgbWF5IGNvbnNpZGVyIGFwcGx5aW5nIHRoZSBmb2xsb3dpbmcg
Y2hhbmdlIG9uIHRvcCBvZiB5b3VyIGF0dGFjaGVkDQpwYXRjaDoNCioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
DQpkaWZmIC0tZ2l0IGEvZnMvbnRmcy9pbm9kZS5jIGIvZnMvbnRmcy9pbm9kZS5jDQppbmRleCBl
MWM1YTc2N2U2MmIuLmMwZTI1MzU0MDFiYiAxMDA2NDQNCi0tLSBhL2ZzL250ZnMvaW5vZGUuYw0K
KysrIGIvZnMvbnRmcy9pbm9kZS5jDQpAQCAtOTU5LDYgKzk1OSwxNSBAQCBzdGF0aWMgaW50IG50
ZnNfcmVhZF9sb2NrZWRfaW5vZGUoc3RydWN0IGlub2RlICp2aSkNCiAgICAgICAgICAgICAgICAg
Z290byB1bm1fZXJyX291dDsNCiAgICAgICAgIH0NCg0KKyAgICAgICAvKiBDbGFzc2lmeSAkRXh0
ZW5kIGNoaWxkcmVuIHJlZ2FyZGxlc3Mgb2YgdGhlaXIgZGF0YS9pbmRleA0KbGF5b3V0LiAqLw0K
KyAgICAgICBpZiAobmktPm1mdF9ubyA+PSBGSUxFX2ZpcnN0X3VzZXIpIHsNCisgICAgICAgICAg
ICAgICBlcnIgPSBudGZzX2lzX2V4dGVuZGVkX3N5c3RlbV9maWxlKGN0eCk7DQorICAgICAgICAg
ICAgICAgaWYgKGVyciA8IDApDQorICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubV9lcnJf
b3V0Ow0KKyAgICAgICAgICAgICAgIGlmIChlcnIgPiAwKQ0KKyAgICAgICAgICAgICAgICAgICAg
ICAgTklub1NldEV4dGVuZFN5cyhuaSk7DQorICAgICAgIH0NCisNCiAgICAgICAgIGlmIChuaS0+
ZmxhZ3MgJiBGSUxFX0FUVFJfUkVQQVJTRV9QT0lOVCkgew0KICAgICAgICAgICAgICAgICB1bnNp
Z25lZCBpbnQgbW9kZTsNCg0KQEAgLTExNjMsNyArMTE3Miw2IEBAIHN0YXRpYyBpbnQgbnRmc19y
ZWFkX2xvY2tlZF9pbm9kZShzdHJ1Y3QgaW5vZGUgKnZpKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgIGV4dGVuZF9zeXMgPSBudGZzX2lzX2V4
dGVuZGVkX3N5c3RlbV9maWxlKGN0eCk7DQogICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGV4
dGVuZF9zeXMgPiAwKSB7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5Jbm9TZXRF
eHRlbmRTeXMobmkpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKG0tPmZs
YWdzICYgTUZUX1JFQ09SRF9JU19WSUVXX0lOREVYKSB7DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmIChleHRlbmRfc3lzID09IDIpIHsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuYW1lID0gcmVwYXJzZV9pbmRleF9u
YW1lOw0KDQo=
