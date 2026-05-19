Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239D3BB9F3;
	Tue, 19 May 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225025; cv=fail; b=Rp6Rd/W7zLb9/e/r0gieNXcbsNf317YfxnbQGIUppI58Bh7T0cq2wcX/LlQ2Mgu8DHMecxRSxWwyXARd/JfHI5Yc3qQ3hzAuo/Qljx3TfT5dhBuPBsnuq2xODkZkrGqqItZCTKhme401TxXEo23HFh9MQIG9b+Ntu/5BlUwBVUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225025; c=relaxed/simple;
	bh=i7Ys7n+xy68jvTYnfcCBeo14nkUNWYMjWaYohMMVGGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d25ydlFanP6IQpp0wWE3fWWYajkPU3D8EmmOp0H+NLAlZadUtDqf6eCjubADmI/y6mMaG5bCp9ZAMTn1Yga4lFvs7nZVBn6qCGvzuXJhGdSmBtpOOC5/8Aw6zP7FPOu2PW+/GqsV5ILTvEPT/Cx7qp3flxLgmf+XEEOVftygK1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JtpS3X1b; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JtpS3X1b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JF0jul896528;
	Tue, 19 May 2026 21:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=i7Ys7n+xy68jvTYnfcCBeo14nkUNWYMjWaYohMMVGGc=; b=JtpS3X1b
	rIVZcLgQcKcyqTrYPTdU5ee70pk9md36dloeMgXtFxichtIY13WKqQaJ6qCYEdXM
	w+5sAyw6ISOo2cI+nUls57i6RfMkqlpwrqd6t25fBxGgyMZLmlf5aP5nwu6etwdJ
	/NVKGYeCliIx5s7c0gY3dDR9ZCIoCxd6dHJz4aabwit09Z66srvNzNjg/e0+x7uo
	2Zd44IdtndJE26OOyO0fEEYUsnG9pFgHEiRNuOD80xviR98CzCtsNN07nOZ6TUNq
	t7s9tzr4goYPAObKZLrYRjhBPwY9atW2O+lTSbtALPvnvDmu6DCyeNEfl2Ds6Cl1
	jb5JjA1yjlfoyw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw6b5k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 21:10:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW7p8C/fkTPS3UkMOKxaQENWff9qB25c/eIOAm889Cme3cJbs+S792m1JUZEmh7lPwbuZFJy2il0JnyucvGJ+Ht8+nhgJPx9FeC6QVhVbsr9SPbTBroT7pVk3w6HEtUt/W02+xdhLyIDiXol5nWS/XOhDw0YO7ocAxZLifPOpwjhK2GF+AU/wmUDAFwBEn2zdisN6/rbMrJe6L7rQt/bb8vsF7udRrB1gvC5a/Dq4W6jgsdki3XRlEtW6Ee+P8G0Hrqc2/9Px0/kedhht1iOkiThVXKVE7Opbc/77mMewL3zTvo0MwKCXxvLWiG6AeIxFb9G6r2UqYkLqXyUtt0RAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Ys7n+xy68jvTYnfcCBeo14nkUNWYMjWaYohMMVGGc=;
 b=Jv9O5GsAqf+RB27/LPCasoUWftxsDmXAH72vIKmU6g0FNbo+fnECbJC47N8EXy/9oMpbZ727a8hv87SElQAKh6uqCR/8oZVa5XrJ+3fJkTFqDBNFooiNfwyu//LnNEdOyzS4Wpxt/KlmG7AIto2GSje1lEffiXLyFY6sAJtpazlqNmq9Fq293Ai8TtCRk7lBqilEFXGyvAVfyB51vwHQ1K/abDP0ksWWPgBRz8VmUbI/clZLhSULlGR076YZ0SnaBsotBMjawg7kSQjKlgf7FRCUsVMCLCtNaGbXqj0O69zxi9v+teqNb98FxATz4bS6wwmgxYFi+Rn7qPQfnXcNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5592.namprd15.prod.outlook.com (2603:10b6:8:108::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 21:09:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 21:09:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7] hfs: validate record ID against requested CNID in
 hfs_cat_find_brec()
Thread-Topic: [PATCH v7] hfs: validate record ID against requested CNID in
 hfs_cat_find_brec()
Thread-Index: AQHc59PY0XfSLdgLvUCr/DQUW9zWcA==
Date: Tue, 19 May 2026 21:09:56 +0000
Message-ID: <056cb181540c72110b973fcaa0e1b11552623649.camel@ibm.com>
References: <20260311211309.27856-1-contact@gvernon.com>
	 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
	 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
	 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
	 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
	 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
	 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
	 <abnzsVk9JNN3alKq@Bertha>
	 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
	 <absr9g7LaMEHfw47@Bertha>
	 <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
	 <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
	 <9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp>
	 <c80f3c36-4c66-4e51-ab3e-e83d37b60131@I-love.SAKURA.ne.jp>
	 <5ff5f107e5a8588367b3af77748369c166f16cc7.camel@ibm.com>
	 <7c54e697-9a96-4304-826e-8a437218f5e4@I-love.SAKURA.ne.jp>
In-Reply-To: <7c54e697-9a96-4304-826e-8a437218f5e4@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5592:EE_
x-ms-office365-filtering-correlation-id: 3ef088e3-93f1-4428-b56e-08deb5eafa98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|4143699003|11063799006|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info:
 9dgdUO6Ij14Q93F0OeDGaGJl3dT2XPVdjrKfJ+AfswsoKgXFwVnjKs/3a5DU4UBSLREtvmsJO97ragzv3Bav+NntoxVdB+VkPrY0FU77lA/V3QPdHIbNWimn5ZSDjDMUT6+YfpDSKHAS9jULi9U2sprp9ykDt5q4Co4gx5hfkQG2ffbhOJwpS13v1xnNOpHNMBFqT0GOxE7sMrAjLoHtsmP8eFdc50uhIlSP06URTvdBFKX8LqhHJvT9ACT5hWDFnPcf6icZuZBzZe5MKrwBW3fDmHB+ZgAZ1ek7h+eR9oMF36gaRciiJ1FDOIy6PBgLcYrYFEaPvsHgLwp/8kC01eccGxXwhnWNqew5Zuv6QrupkkY9j1+/iYMZIy8NXSP/AspcdC23MvsZ+Nz2wvR9IBrG1a2Daiatt20r2JExUXvcPMuz+tdOaeTqjA/+zRZSVBEwDjX6cWxwpq73PpfueupdYlJAjvPU3Ns7f5Hh9UEhmWJogh9JmVm+YA7gfNSRNgJqMUb0xeTshyPn2neVYsyo1dvvRI2rzrE+wImceYv7+ei/DsXBhnDlcOhxmOnajfpuM5uKxmskDqKcakiRdb6c5BVJ8qk7R5IP6NQY5sUDXC3HcdoQOpARa0C7G0An5fz5rxHR5YWJAwF7Djj4aFxSDciA8xYNBJre251tVqco+Q2/HMgtMiUaRg64FlQ8BG22k0mpGB4CiBaKGd1yCT3B3ukZlWKYjN7vif5RywqC3Mb8uTF4ZmhG8UwBmmYa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVdvRnJHQmlrVjdZcDgxcDFMbUU3ZVFiSURZQTNqbmpnWFhVS3BZZzB2OVk4?=
 =?utf-8?B?MDBPWElvN2VZd3hiSEhRaWNRZFR0RnBtNXJ0NDloczdnV3pWTTYvWU14dGNI?=
 =?utf-8?B?S253TDFMWEJadDd2YUhjV25kSFVwd29SODgwSVR0RGVIMFprNFZmRUVGOWt1?=
 =?utf-8?B?ZHpQb09BQXB4NWJBSVVwMVllWXpjenQvbXdaMEZwZmhPSXYwZVBVb1U0ZGsv?=
 =?utf-8?B?TWtoaU04QXhIMW5QdjNBTThyRGhNMTN6eHBuazNSZ2loelNrZGNwUVRWV0Jr?=
 =?utf-8?B?dWFuQ2V4UVF1L0ZVQUtCOEFLTTNHRU1VdTAza1gvL2ZWOTBwbU5RV1dmWGVH?=
 =?utf-8?B?akVrbnloNFJJUzFwVjVDWUJFRlB0aW1YbEk5VVRhUlhScm55RGZFZzRtV1pM?=
 =?utf-8?B?WlFIQ2h2bFl6Nm85eExhK09iczE0WnJZWnZoeXJYZFd3bUZMNDFqZktBV3NR?=
 =?utf-8?B?ZEY5K1doK0tOVHVxWndQbnRtTWlhZ0tXQkdtaEpGR3gvZ2ZYYWRXYzVzSGk3?=
 =?utf-8?B?a0FWYUt2ejFnRzJ5SENaSEp4M3ZLNVFqTWhFQ2RYOEgrR3Rqem1sQmx3ek04?=
 =?utf-8?B?aDRTZUxVcWZlVjJ1bVF6Y3VaTWJMS1QxYkcwSzNCQ0pvaHNlNzZ3YXRSVTZX?=
 =?utf-8?B?bjJCRlE4dGhhZlZWb3ptSUl0VVZ1eTdvRHdWTW90YXFuQVV3WFpIT09FdG8w?=
 =?utf-8?B?RU5XS3JSZUNqWEUrNWFjZjVqcnp6dTlKYkRYYXl4THN2NnNkUUY2SFpPOUtm?=
 =?utf-8?B?cWZFTzJqUHU5Wmo2c1IzbmQxNHZEUEdBcVE3VjNvdHN2WldDUGtDcHBDcUxV?=
 =?utf-8?B?QUo5SDQ4N2xlZW5zR28vZE5JY3pZYklFcERqWCtoVXU2SGpUbFRqMGVITVFB?=
 =?utf-8?B?M3ZicDJSVnlqcWxhbW56eXRPWDJjYm1BbllMS3hMaDlNaVdHdERJMGdmRERq?=
 =?utf-8?B?MW1JMXd2S2tmYkJrRm92MmRKYWRWTis4NmNneE0yVlZ5RDlMKytxY0lGQzFm?=
 =?utf-8?B?T1UyS2Y3cWtuOHd2aUFIa2prRVVTM3FyVGlJNVBudEllRXpXQStpUTJhQXZi?=
 =?utf-8?B?bTBaSVRqZnc3dTVrT3ZYa3dqRnQ4Q2t1WlJFUVdRVFNlYnRCM0o2MWdzYjBM?=
 =?utf-8?B?Z2R2djdvVmErdkY0RmptMitWQ0cxUXNJMk91QjJRVkxYcTdMcktVMjNCZ1lU?=
 =?utf-8?B?ajZFVFFGNTI2R2wzTzdkZEEwWkxCNTZjWE8xWFcxRnVjRmpmd0ZiK2dEd1FN?=
 =?utf-8?B?YXAwMU5vOUM0WmNjZjZPVVVWRiswVk5nM0loNzV6QzRrNTJvakNCbG80OEhZ?=
 =?utf-8?B?cVByL1RkYjN0cit5cGlyNys0RzdVYS9NUFpZMEI1REFaTmxyU25ocHdLYjFr?=
 =?utf-8?B?WkxrUTFINUh4Y3BNWHo0bks4ZC9vTGZtRmV2YnBjaW9Vd2JJRWpjUHIvdllr?=
 =?utf-8?B?SXliNGVZMHF3amFJdmI4S2VTdVpWS2piUjZMSGNDeU1ESkg4NVhBaXdFR1V4?=
 =?utf-8?B?emFPbFR5TkRLcnpRK2lTRWRJdmdIcnNvVmgwb3drTFJzYXJCUnp3OVBVdlZO?=
 =?utf-8?B?RGVMK202TTFXOTNLWmtTdVd2bG92cGxTWTliWlAyR3pYMjJDOHhpaDJCZ0VZ?=
 =?utf-8?B?elRZbjZwaWZzaFgzNEhGd0lnVXJGaTJ5YWZESFMzWWJxVHRvVFgvSmJSSlZZ?=
 =?utf-8?B?bzVtSzUzeFA5VEVvNTFnQ2dhR3gwNlJZZGRiN2JZYUlKTmRzbVYraFNqeXJX?=
 =?utf-8?B?TFYxck8wbFQzRk5UN0haK3hSaFdRYkhveWFUM08zamJVQ3dVblByNm1nb1JB?=
 =?utf-8?B?eGdVczY2Q085bjIyTWRjY3NRWmlVS2NUdFlxRjdjTVRWcUNqY0hQc29QbkFs?=
 =?utf-8?B?bVUzNDNxNjlsT2MxczFjc2I5TWx0ak50ZEhSWnpYN0o5VFJyV25hdkJaSXRJ?=
 =?utf-8?B?N3BicmpOM2JPQ2c1S1JUNDZ4blVJZW1yeGI1Mm5xeGhreDJWZk5MQ2pJNWdO?=
 =?utf-8?B?V2Ewc3BnMDVNUnpIREM2bUVVb09GSS8yelN5S3BnR0tGT3RkM0lPVFpOTWZl?=
 =?utf-8?B?YnI1RlBINGdVTnZMMkpRdGV5bEFpLzdRNVZXejZjbkZlUXNBL0doMjJRSEVE?=
 =?utf-8?B?MjUzbFBXSHVnYmZsTVhrTHFFL1UrN0x2Sm1EREpEcWtiNXNjcENzMXRYeDRt?=
 =?utf-8?B?bkEzTDRTdXBKc0hHTUJGTVA0ZzgxWEJTakhnWnBWWEE5Q1NIOHZDNk9oc0dL?=
 =?utf-8?B?Z0JtMU9iY2xzUE9qVGlDdkpyTXJvSmdZNTl0RG8zekx1NkIvN0xCWmp4Wi90?=
 =?utf-8?B?b2NiUEhVay9SRm5DWHVaMXVnZ3RjeENIaGlIVTN3b2VsWmJUTVp3MDNjc3dD?=
 =?utf-8?Q?aUjWHQNdzqmwDk0PV4Ch8VXR6oXMf+Wg8t7xT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67D9470F78390A41AFA8337F361368B3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kl8OBagewKQD7Hxldz3qxMhOgHpz8MuHHErBJ5FSj7kDU+lqgh3A/z2Gmhu9UUUz0QmWNGZDFyv3VU1pVUn0wAetpOFFKCCzoU620CcQO8EEq+oifLkmlH3/vD35/NqEd2BXpU7h/mueOgbeTNfZgFpl5T+qdh727cvaBsilXzetirisz2UOKJ7qWYCXxsEu44DVWdHCGpVchKjUPNu+oBsV0IbErv5oise7LXlqdos+QiC9NAR1UXT0SSLLN307lkBgLjANYewf2jL+ziiV41LAW4l4DbsWVsMtoW4VLNhkQ6hwrypffarmnpPKBlGwHcNd69JQLOJWpqwxpjfzPw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef088e3-93f1-4428-b56e-08deb5eafa98
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 21:09:56.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4i9Lx0paHZFJagKCg5XMWllCg56NRJ/bGOOIsudDwMVpBrOJ1sWZNjNdbonLgB0NEBdW9CD2tH9JyKGnFfXBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIxMSBTYWx0ZWRfX72ZRPGioMca7
 0Wb839ggp3vssYexRSkjrtUgH3UF3iG8xw1pCQ1EbCiaFlbj+yPCJ2aKF53H0BvR3fZJ3WXM150
 vjrc6IKKssdibvvBtDAWSAIWjd/J03lX0njpuavNMqbm9N2gCY+U5B3PuhZ6kx68+0eIAUT5KyW
 KgAAw+vdRP1rEnd8NkQAdY/HbkO76GqUvcgG/w2qXfvVNk+PJZ7qThob4q992WZvUjzeL92zfw7
 cde+bDMfrUyQMpGhOe3kvZR/qcd5zP2z59ayvUbOxv440gSuoFaKNg3a+E4crVaLyIAuiFc56Zp
 NNo6iJ9+vQeG2KAKExKOh8PmF+5HZv1DiB5Lb8FYij3UPOrRzqtDqs20xJ6aIhSjnct07TPjzwj
 EyyADFsBGQY6AfMr89QkN7291Z0rFumj1/hiMhaEQTd+jZwcRxD/rDDqhBh10/cdAQUy+hKVzTg
 0fcf6YjD8Xz7F5/zVbw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0cd1a9 cx=c_pps
 a=jJxBgQE0Gv9vBhouG1T1Tg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=PAU-dpGF5F-vWCRzSJoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T9Wi4VTfK9D9Uni5XRFkeJXRx8f0U9qp
X-Proofpoint-GUID: T9Wi4VTfK9D9Uni5XRFkeJXRx8f0U9qp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190211

T24gU2F0LCAyMDI2LTA1LTE2IGF0IDE1OjE3ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDUvMTYgNjoxMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyNi0wNS0xNCBhdCAxNjozNCArMDkwMCwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+ID4g
c3l6Ym90IGlzIHJlcG9ydGluZyB0aGF0IEJVRygpIGluIGhmc193cml0ZV9pbm9kZSgpIGZpcmVz
IHVwb24gdW5tb3VudA0KPiA+ID4gb3BlcmF0aW9uIHdoZW4gdGhlIGlub2RlIG51bWJlciBvZiB0
aGUgcmVjb3JkIHJldHJpZXZlZCBhcyBhIHJlc3VsdCBvZg0KPiA+ID4gaGZzX2NhdF9maW5kX2Jy
ZWMoSEZTX1JPT1RfQ05JRCkgaXMgbm90IEhGU19ST09UX0NOSUQsIGZvcg0KPiA+ID4gY29tbWl0
IGI5MDViYWZkZWEyMSAoImhmczogU2FuaXR5IGNoZWNrIHRoZSByb290IHJlY29yZCIpIGNoZWNr
ZWQNCj4gPiA+IHRoZSByZWNvcmQgc2l6ZSBhbmQgdGhlIHJlY29yZCB0eXBlIGJ1dCBkaWQgbm90
IGNoZWNrIHRoZSBpbm9kZSBudW1iZXIuDQo+ID4gPiANCj4gPiA+IEluaXRpYWxseSwgVmlhY2hl
c2xhdiBEdWJleWtvIHdhcyBhc3N1bWluZyB0aGF0IHdlIGNhbiBmaXggdGhpcyBwcm9ibGVtDQo+
ID4gPiBieSBhZGRpbmcgdmFsaWRhdGlvbiB0byBoZnNfcmVhZF9pbm9kZSgpLCBhbmQgR2Vvcmdl
IEFudGhvbnkgVmVybm9uIGlzDQo+ID4gPiBwcm9wb3NpbmcgYSBwYXRjaCB0aGF0IGFkZHMgdmFs
aWRhdGlvbiB0byBoZnNfcmVhZF9pbm9kZSgpLg0KPiA+ID4gDQo+ID4gDQo+ID4gV2UgY2FuIGZp
eCB0aGUgcHJvYmxlbSBpbiBieSBhZGRpbmcgdmFsaWRhdGlvbiB0byBoZnNfcmVhZF9pbm9kZSgp
Lg0KPiANCj4gTm8sIHdlIGNhbid0LiBXZSBjYW4ndCBmaXggYSBsb2dpY2FsIGVycm9yIHRoYXQg
aGZzX2ZpbGxfc3VwZXIoKSBieSBlcnJvcg0KPiBhY2NlcHRzIGFuIGlub2RlIHdoaWNoIGlzIG5v
dCB0aGUgcm9vdCBpbm9kZSwgYnkgYWRkaW5nIHZhbGlkYXRpb24gdG8NCj4gaGZzX3JlYWRfaW5v
ZGUoKS4NCj4gDQoNCldlIGNhbi4gQW5kIEkgZXhwbGFpbmVkIHRoZSB3YXkuDQoNCj4gPiANCj4g
PiA+IFdoaWxlIEkgYW0gbm90IGFnYWluc3QgYWRkaW5nIHZhbGlkYXRpb24gdG8gaGZzX3JlYWRf
aW5vZGUoKSwgdHJlYXRpbmcNCj4gPiA+IGFuIGlub2RlIHdoaWNoIGlzIG5vdCB0aGUgcm9vdCBp
bm9kZSBhcyBpZiB0aGUgcm9vdCBpbm9kZSBpcyBhIGxvZ2ljYWwNCj4gPiA+IGVycm9yIHdoaWNo
IHNob3VsZCBiZSByZWplY3RlZCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgd2UgaGl0IEJVRygpIG9y
IG5vdC4NCj4gPiA+IEFuZCB3ZSBjb25maXJtZWQgdGhhdCB3ZSBjYW4ndCBmaXggdGhpcyBsb2dp
Y2FsIGVycm9yIGJ5IGFkZGluZyB2YWxpZGF0aW9uDQo+ID4gPiB0byBoZnNfcmVhZF9pbm9kZSgp
Lg0KPiA+ID4gDQo+ID4gDQo+ID4gV2UgaGF2ZW4ndCBjb25maXJtZWQgaXQuIFRoZSBpc3N1ZSBj
YW4gYmUgZml4ZWQgYnkgYWRkaW5nIHZhbGlkYXRpb24gdG8NCj4gPiBoZnNfcmVhZF9pbm9kZSgp
Lg0KPiANCj4gV2UgYWxyZWFkeSBjb25maXJtZWQgaXQsIHlvdSBmb3Jnb3QgaXQuDQo+IGh0dHBz
Oi8vbGttbC5rZXJuZWwub3JnL3IvYjczMTg1ODgtMzNiMi00ZGM2LTk0NjktZTExZGE4NTVmOGFk
QEktbG92ZS5TQUtVUkEubmUuanANCj4gDQoNCk5vLiB3ZSBoYXZlbid0IGNvbmZpcm1lZCBpdC4g
V2UgY2FuIGRvIGl0Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K
