Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794321312;
	b=bwd5rwSVdDW4JVgwDHROw1aquHcqsyElarWAun0Uv0WSZhdR5cB/S8WWIo0+9vyOJBOS
	 +gNNohaHfnhxLiaBjr8mkxcNhgpR9WkyNjad4QmeKyLrnRDEP9XnAA7CRJGn6Ol5gZjO0
	 hyofBTkp1BSEqqQg9DSZrz7Q1rkovERpKBuaBven4Vx77a4GapNFgHv7YP/Hk15EEQVq+
	 xSb0TkYK30hKpXIMx9ZpLYt84qUr00eIn/tbRlXOCYy6/DqHbcPA5mGU9jOVGB7/XjYkP
	 uGQYsD8siNK/wQw6GAgtOjyCOvngEHShBLRIhmySgdYeOTLAi//bPmUe/7R7GY3I4uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321312;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Wisc_ValidFrom:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NiQk8tAV9LuQfK6s+DJHNXi/HjTDMAGW6iC6KuL/XDw=;
	b=simUUhlysHf5VqN6JKqjd4dC60Abv+9rtoCfAkkny8oUeIyE2yPcmuwvOipTPFv65Cli
	 GZvmgeRtNEjEvoNXiy12IFzVi+vJfJDC8nTYcYNLfaCC6GdSQNEPR8spLmbb8HeUzy1/4
	 kkMKdrKwKis11NsHJl16IR+XZjNSLsFtIe0ZTAro191VlkrrfbxkF04Kd0ZW0jATXP79H
	 cakhGcm/62VqRIu2PIS4lMkuOdApB4u5ZKNXRa/XoFURHxO5ZhzioSfGphxcT0VhqxXGs
	 jlPTHM+HZcO8FZsdNVarspJUa17wJwCJLcxZ3bpxwLbWTgHvDXQmmubz9n3bvkAaupA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wisc.edu;
	spf=pass smtp.mailfrom=wisc.edu;
	dkim=pass header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=pps1 header.b=sbAQqNqC;
	dkim=pass header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=selector1 header.b="Rk/XAOSe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.71
Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F2606A32A;
	Tue, 10 Nov 2026 14:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E73F2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=pps1 header.b=sbAQqNqC;
	dkim=pass (2048-bit key, unprotected) header.d=wisc.edu header.i=@wisc.edu header.a=rsa-sha256 header.s=selector1 header.b=Rk/XAOSe
Received: from pps.filterd (m0316046.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAE6PUS1206432;
	Tue, 10 Nov 2026 08:34:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=NiQk8
	tAV9LuQfK6s+DJHNXi/HjTDMAGW6iC6KuL/XDw=; b=sbAQqNqCptQSlKDlqjKws
	if+yrjajg7KdJGNATreS+KzKnDYPGcwddjmUzM/HkViQZ8xBSp/FghlMFNJSsEVa
	VDCeOZ+av5AJimDFG8otCIUBL61PRl+AvDwBt3GHb1+qTyQCxcQk/vGyvAPTevs6
	9BdDhSh1mKu9sGXylTuE8v7b+8wvlVw7vV/h0xFrRCtJEGMvxJ+/dMGZHMXd5Whd
	i6jV3BJifxCjYIC1kh+5K0d3PFPTg2gXLpjkRxl+wfcDpT+A84d+gUoguP93Nn1g
	0S3PKplFw4nD7W1ZputtoSIR5Z3vv9f4IDwGwRwA3C98ZsNveseSOTuGZYMcXDpv
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 4hv4r7g8j6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 08:34:32 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeLqQQl6xdOVUWOEFhTEXwvOffg9cW8LxiAqmcV0UkYERCAxYrKUUfpG8XXtMeQY0TPP2IPltx1KcSU08gNJyQuM3nMzSP46idDYEaMdqfBhbHR3RThbVZSe/IgcoePR5/WRTiwAzjaGRkdOhzogUjK7FWXzBIFmVc4Pf/dnazHlNC+xom8wDv0OAKip9tbIn6qsgquJfOm4qbIlYsUagbvM8TycGjmd/IRhRDuWOsVUrSDhx/9MHJw+S9lR1FEFuITAoOTKquIj/0f23dbH3M2htjzt73S+/1b+KTbLjNFhVULAMf3RdLYOU88UjdlrH5sNpScspRqDxJCXCETrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiQk8tAV9LuQfK6s+DJHNXi/HjTDMAGW6iC6KuL/XDw=;
 b=Qbb81LTGXVSMaax42d2zljyvd696zj2OoDa3IaUGpbxTaxxMZRZMMRgzLRnKd2eAJitZ6EDAr5Yp8Z0bHxN/eyZ6TuXLCVbV55XpoTMB2z8d6idtd++8ky1OmzpuNu6OkGQukVtJipVE7DtZq7WXlgCdKxzwnGZbmkMIMReTDrDsjHB5gluHDdE3koqEvl7/EpsQB/BVHFtR7LuXjeZYEekB1rz5iK1R2DAFtoYgSgPiiv6tiwmXp9ihlAzSu26sTzS3eKo9y/I/VVVvbk8b4q1GrwXkX7Uo7qjoQyyq6mleGUOb8yjVGWXN7sYH4QsIQwJcr0hvAMH1PC89hSj3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wisc.edu; dmarc=pass action=none header.from=wisc.edu;
 dkim=pass header.d=wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQk8tAV9LuQfK6s+DJHNXi/HjTDMAGW6iC6KuL/XDw=;
 b=Rk/XAOSeQ/e36kZyPrIMtpnnv983VdYA/bfN7OuQ6etaxEDc/oGCUvsOWqLlEPWKb5xOg6k3myGRZxs98jlgVQbSBMYGy2njw+11nv3ao9FhcP1N4/DNzEcYNYyr5alhTPOLU0JS2GPLybTBH/3tKRU3i83dmryIN/McxUkdSkhiWF9JiHYIEApGmsNENrVn6ibqD7oN2NClf5ZczcOuvm+GxFyBYxkeXgkJ6AL+XRb9I/gI/CFZ1lvmAMgjcA1eXfaPSIAHcvlFTeJWWzEXQDTowEHM4mHi4Kwkx/My8nCMoADqeJz7xNr1ym7jCwToQ3dsMVDZiEi/jrgPRoDDmQ==
Received: from MN2PR06MB6639.namprd06.prod.outlook.com (2603:10b6:208:20a::22)
 by SA1PR06MB999793.namprd06.prod.outlook.com (2603:10b6:806:4f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 14:34:31 +0000
Received: from MN2PR06MB6639.namprd06.prod.outlook.com
 ([fe80::c7c1:6e17:5f9d:1245]) by MN2PR06MB6639.namprd06.prod.outlook.com
 ([fe80::c7c1:6e17:5f9d:1245%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:34:31 +0000
From: Seunghyun An <san55@wisc.edu>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Vlastimil
 Babka <vbabka@kernel.org>,
        "Liam R . Howlett" <liam@infradead.org>, Jann Horn
	<jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 0/2] mm: avoid redundant reads of the vm_refcnt cacheline
 in anonymous faults
Thread-Topic: [PATCH 0/2] mm: avoid redundant reads of the vm_refcnt cacheline
 in anonymous faults
Thread-Index: AQHdcKZz6DuTj3OKQkaTRRr2umEtsrcnJNgAgAA7DYQ=
Date: Tue, 10 Nov 2026 14:34:31 +0000
Message-ID:
 <MN2PR06MB66398F39E876279DA2CA8A52D2722@MN2PR06MB6639.namprd06.prod.outlook.com>
References: <20261110000002.1834454-1-san55@wisc.edu>
 <avLxcf8KaFP_XPnM@gremlin>
In-Reply-To: <avLxcf8KaFP_XPnM@gremlin>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wisc.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR06MB6639:EE_|SA1PR06MB999793:EE_
x-ms-office365-filtering-correlation-id: 1244c720-f880-4543-5eff-08df3f37bbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|7416014|376014|1800799024|23010399003|366016|38070700021|261028144727099003|4143699003|56012099006|261026140227099003|261022105027099003|261021121427099003|261102123227099003|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 iBLxEkB6mmolGktQyS6h87eFFRYf5FZib1Gw68Ipy8QQUQAlVTq2TOGJbWBMXW6GRXj8EwZcuyIV/VAtP+ktjKRX7FeS5IIcU4LLJ4bw5xV6BPhWEPEXmQFFcZji+PZ8Usi+tPPjKCYB9ksfWrBXmxqFeRdoLgR0rsmycVXueQbp4B+38qY91wRsqixZ9MOziQRhG1FBwl5zNXdhoVjqjeSXhgbGF/1PfuGrmEGUy5whwnTP5SdCBlPvx7a01ekkCpW3OCqeklR6B7P3y5BaveyoYIlV5NtIRhd52KMRlDiy5ekgn2ixjFrc+xiTfNxTbtjLoCn8qytaVTY+JihAkgObs1K1IUjfEkCwUzzp28HXf/UdZ3oTUdDmIwomSud0A0BXbM3kjbbz0zfo4VKwnuq7BHnp7mqppXpzowe8lXytoXHrwLtZomoSfGFdamDe+kojj8s3iFk53E/RCy3S0z3HytHda+sk7I3pbkJd6n1zMvSn+164wwZw1eiaUI0gvyZP1VecTWKL01tDHy/PVdUahLGjisKpSzdN6c1mIeaHWsUrkCPQ98LnbODYo9NoPEU4oEwa0R0iIKBeg3dvd7quHCf0J5gz3vhpb/SHomgmiUYDDsxKtn27GR8iFN0nJq4ZbMA/LDufdG9v5esoCtlWDbcfnux2sOWmmEoN3fK4ijBbTDfzjEHJ9vfqmb1uUUxb9z+wLsN3UHvRQS0a+UlNVtbEGPhXi3ITupRZYn8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR06MB6639.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(7416014)(376014)(1800799024)(23010399003)(366016)(38070700021)(261028144727099003)(4143699003)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261102123227099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SpzyJkQuTi9rLpgzpw4+ZfAMTbxMrOSoBtLoqqElFi+VGYe5mnclxNuvh6de?=
 =?us-ascii?Q?19pzZXu4V4/rjLkvE1CXdLacLjAaC7TCpwBAX791rexx3li5MUMTxpp8IdkE?=
 =?us-ascii?Q?MHfZMzG96P2U1O8mnXq9KFB00OQw6bKEuSsuiO8xOZ03kpZkXOvmRseOi3zs?=
 =?us-ascii?Q?ZtZg5S9HjIJlCYqhMK9fRd5mNLSyGxGUVmbc9Os0GeFGGg8TkSoIpl03GmE5?=
 =?us-ascii?Q?IAMRNlvf7UsVuOXe1f808D/VCDV011pdtQDe+tOaTntxys+9GyYjRlEQatOk?=
 =?us-ascii?Q?mCxzkZzoKooVTm5UIkeUS1xQL2/V2jhrOtUupDYKyYNiEa+SA9XXFnjfdcXy?=
 =?us-ascii?Q?L28AVn5SpT18h1zINHfGkKsvs08VL6C12EKMaZK6y2AJDYVOulz/gQiMIWLd?=
 =?us-ascii?Q?dnl17NdeHkT7WPSDHixus8vaGowNEz72TE5lAh2VOjUgYCa4chGnqxKynSvx?=
 =?us-ascii?Q?g834ZQ28bfuOta9VDxV8r1NQFfEYLG0JOqCghzi9UKR4HcDMh5CgtFuvWOPZ?=
 =?us-ascii?Q?aRivnwYjava4LyHQrU0wd202TF+vEMqA5GRkDJ90xeHZbpBR6/nhId4ikPzE?=
 =?us-ascii?Q?DiBmugJVYn2otVJmoL71MFaalUkKz3kix5s8qGWnZgotTnsHn6u/C+LDQc6K?=
 =?us-ascii?Q?BDXdfq+LvKp4T9SKHbhvdaIquba04NjPaVXD6e64zjOzWS3gMpxa4/9bqAGt?=
 =?us-ascii?Q?SWfroUKt5G9B3jEGjey46+8lXZ4y5sAGztVTxHXVZHwJRxEDw0LbgPc0RUWF?=
 =?us-ascii?Q?GleQPW5UYZ/nd1KjV319Tmth71cG0tLalV+FLWInrLPjqqK3DL/7A6dxXT8w?=
 =?us-ascii?Q?sjrlLztkRRGxODmooWws/Bn6ZJBOLG4X7t7gnBaJ39kLOFT43060JAVbnJte?=
 =?us-ascii?Q?3y4oGgXKeMyuuZYGV1Z53OmjqXkeNlCM70Pg9NQgDl3PLes8DINzYzNJWNYz?=
 =?us-ascii?Q?QlSjb3haa0e0TAfj6RTiFcVQoB1mSNUIxyn/PisYZpN1y58HZfdwAm4vm/y2?=
 =?us-ascii?Q?IfYtEfVH0NMe3ve/tcCCUXkf2gZdhKjKbOXUNaPD7TVblF2mklfWExsZzEEi?=
 =?us-ascii?Q?M/vBCxxUpZn4EYspeF0Og6y0sIsqZ0SmMYkpGr0FgDdb5vRRClsSmcw/a8c6?=
 =?us-ascii?Q?TqiWHNcWdTXYoQLgNUPe64yAYhuNF908KHSrcqigNfDWlBo/R5u3DQFl6bl+?=
 =?us-ascii?Q?ltu1rJrVDABpSsoP+psn9lYjN1l6Y8WORgAE6J72t3c8xpNKKrM3kMFXgQId?=
 =?us-ascii?Q?Ttvt0hxsMa10AjIYYeD8QM7ZUiYyJ/4VHo0ntFSVkHFJgFbAnC+r+KMFNhij?=
 =?us-ascii?Q?lALRY+iWcyJgIa0IYBzojvOUYVYghmpXVkcRGAYIrrs8IfST6vlyfFU+8oiW?=
 =?us-ascii?Q?88hnO0kCE2jgYh+55HNoZfcuCJBjKGFKyzPo1atTqn6xDWPE8G7LQiwLQ/xU?=
 =?us-ascii?Q?UuQkLrhCB3jXbnpV5+Dtfcn8t+akSnKgK2jJV72xnIfKeSQHiDq/yk0iScD2?=
 =?us-ascii?Q?cYP5t+wbXAnZuEIeI/BcD2t/thW2s3FZ+qGNk2m8IujNzA1Vyu+CrmZtXmbz?=
 =?us-ascii?Q?Tr9CfUUMYhmMVkRM3yoP6Foq5ZeE67dup8gUAew+NfOhBb67Q2srHVR9vE5s?=
 =?us-ascii?Q?oeHvBJkkTFcapLbfw6FPr0Rw2cy/PzzZiiI/CAnCvjes4eZlaBuNummL+Mm0?=
 =?us-ascii?Q?E+94umAFtvN+7kSOzfnLl9RXTnpqJS2kKZlpHrrLb4ZQYIIj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	yzVoNSGdY9WxwHQYtAm3PDgeLB4V3hWIE5sRi/1LiIZl/o2Nu1ejsJCeaw0hXO17KRdlZutIRiDTxP0Gs8NFaGp+VcJLg4v8ekRa6idrE5RpdBx7otT+ZPIDk4Y9Ug6aJfaQjroiTuSANeiReOx44nggB4POcHsAldhx0Db7ZIcU/6DSdwQjwIuIIsSHnwxlUHfOS/HeiUwpn1eJ+E4/oCFX2UbJIzhftDSgXiM2+kV/XagXMph/vM5j8WJsAj9XG+smV3d+9xDVJzXEEgoNIujkXUgQnmMeS8Fgnm8FyrC7ZI2M5vqEKeUjMX5cH7Tg/pqkQeE7Z8bH7tNsmYayQA==
X-OriginatorOrg: wisc.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB6639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1244c720-f880-4543-5eff-08df3f37bbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 14:34:31.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I06JqEMVzORZ6imTP9mKrNFjrBGcqbNUNrGmJAgT6gd6pDNTqOQX9P2OQvxUdvw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR06MB999793
X-Proofpoint-ORIG-GUID: KP7bZAJHTvrpesbUP7aJsCc99Z1yLYWY
X-Authority-Analysis: v=2.4 cv=C9p8WgP+ c=1 sm=1 tr=0 ts=6af32b78 cx=c_pps
 a=T5SYj2RWWwK9pVLeGBda9g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=U-hppK1rdbEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ZyELlZqCvD1aXIDzc3I-:22 a=XiWqTFSM81oo9FNMAQdw:22
 a=E6StuLRLpgRRZcBR-4wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NyBTYWx0ZWRfX2S4IY42dl/eo
 Bo9zcQhILoooI/S/YJ8SjSNP2cPx++UwLYHg2zFtm2afyAfguc9FGgYyuY22cd2irxR1nzGoaoX
 jbVKUQefIfJMfMIswTD+SRIUJUg/UJs=
X-Proofpoint-GUID: KP7bZAJHTvrpesbUP7aJsCc99Z1yLYWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NyBTYWx0ZWRfXwvkKeUCq7+x4
 Nr5N546vyxICt7+n37UHTWtaKy2SPLC4yzfOB9fxkjuGj1N3qcsDJwNXLpoMgu4UGCgvtvzxFMp
 vInomQMwqnpjDdJW0zvroBUWK1pvMCTpExhKVy8X6ayzqHzPWNJd9N5TEqCXseVTSIJzIfOH4s9
 xflHlZ+ipxOiF6zpre38fnL66ScM1jT8sXA2X5XCvUHdwIqgi0UeXt134TnGXQWGp0uk1hFrBZ5
 O8j6Pq1T7xBPA90H/W+NFXd1qhBkrXGmCDlppNQ78HB1ZUa2IKGwQPVmkwdFD5BM4JDd9BUMErZ
 YCUexcktUacwgWN4WW2KvPe/Zmi5tbBZLfOZTNRTFjone33ThYR+XUuqV8Zytn5dqwJleO+UJ6v
 +eEOwBr1+J3A0dDILGI5a8EMprnyj6eBGvmBfJsq3rvyy8CoKPvaqRlIOLx84jiqPIcheczmL4N
 9nu/TuhZ+ljBoARqvUw==
X-Wisc_ValidFrom: true
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100057

Thanks for taking this on.=0A=
=0A=
I should have disclosed the LLM involvement up front, and I'm sorry=0A=
I didn't. I came across this while researching the performance of the=0A=
anonymous fault path and worked with Claude to investigate and quantify=0A=
it. Claude also drafted the code and changelogs.=0A=
=0A=
My main aim was to report the findings to the community. In hindsight,=0A=
a plain report would have been a better way to raise it. I wanted to share=
=0A=
the measured effects, especially on EPYC given the higher cross-CCD=0A=
coherency penalty, and offer a possible way to address them.=0A=
=0A=
I'd be glad to collaborate on measurements for your series and any=0A=
follow-up work in this area.=0A=
=0A=
Thanks,=0A=
Seunghyun=0A=
