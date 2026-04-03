Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AD2737EB;
	Fri,  3 Apr 2026 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183685; cv=fail; b=OFUCvVto8wScuW1Nrld57Wjiztu/5wO6geoiEtnzKKA0geO4CcV1oF+H1vO4FTbui7OlFcM0sdF8MABlc40Zu2ZsvljrDKAZPtXD6ysgTKcuFLvL3XSKeeQAT3hALsIQMrsHQxmpNnOdzAf9IjhZYGVvf1cQpd3sEuqm6H4cNa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183685; c=relaxed/simple;
	bh=nycE6sw/MpZsG0lQbG8ji4vTaeY/wSLznZyP72cblk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2qAtyCeZi4puLZaqvxrMpN1yuvXl8SLsZSmMbvRFZ9XUEpFn6I6ygWsnlcm14taG1ANj9dCVgJfUglClX3lsWrpM74JCKxiZSGqb7SbfIInmJNcivzG25y7Wg2L9Ra0e8q50f4Tfqk9tv4NTkKDoAKgu/UBOymmBnFe0zQAYH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YqKNmUZW; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YqKNmUZW"
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63323d4h3283213;
	Fri, 3 Apr 2026 02:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=DuSxRw8
	/srOwavT35CIK801z91L5XqTSjZMlQPaKFgc=; b=YqKNmUZW/tjrV4WcudiidjH
	QacozXt8Hx8OB52SqfPcO+5XAUaCVgO3aZz4csCzti6ve3k8pxnusGjAHujfVsk/
	guzFkA0Niimbf/HVsjjPR9Gd/D/2E28PD8lKdreGyAvsbhiB/3BRJhp2xBjUHi51
	dtbwrSkfW06W2nl/PPKhB0wCzs7ZvZIgd9rNxFimIrAkPkBDb9JHqaG4s/7mfklZ
	rJgU7G8AwFkA0QVjNlWbbf2GOGd2pyUAl9H5+v37hCpeozwHgH3bDrZP8yEevNCe
	6OHTSwSpRJkA1f6lEFcAJUHqohy4WznCdgp/iMv0dcYQoCOmVsBHwOoGtuuTXGA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012005.outbound.protection.outlook.com [52.101.126.5])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4d64507hbq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 02:34:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfD+TjdbZI6FUNobRWO0m6IU9HY3xaFpn4FNoZtHchgJD6zAWRRjGOwi224DC7SdAsV3gpZAB6JlUwfx3mo+EVMD+3OIqUa3eUrZ2MNbU24PxIvjD4pnX0LS/TZz72jNC9VfDoMzP6NVLqLf53nc60DW+fWQTjZ4B3m8NkhroD9vdo0OP8KfihHIR7vE711BihL9FycE3Ni7Ds6CAQDYKIguunEaoTcQDoTYKNALX7F3b1RioibkxUiWBbWXL+fCm1kTSA3Nl7BRAYN+90K1dbgoCLWqqAM4Euc1Ysm+GtZmjDsx3oPhlk4+FJwfCQ9JdQFrYEvGbAKfmimoYBrUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuSxRw8/srOwavT35CIK801z91L5XqTSjZMlQPaKFgc=;
 b=mh+0JP6k/KZctAU7QlLyRXeq+SwCEONpbmgDWYnwbGl3buR+wqBPkWVDqh6ivQVJfQbSWAt8zYWHUx6AQBniAQj3XXC1gH05vv4aeASOt5oW2+/OFMiVQKOVnxGw/QOBlgHG6BJPGJM3uV/aGdJezzMTnNOuK+piMtPA8fLJF/ZoET2zezrDfdTOqBwDOq1YihoKVwhFBvhnEuFlvNs7NpWr9RdxgAGcRv219lzNFZlz/1ZyhDW95Rbhdc1LXuCMg3kt1sSyMW45RFUGW2l9+VLvFm/5dkuVn6Wp9XndXbxT7DuZkXYODM50kksh+KuYA54AalO4Emfoa8vKHPI/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OSQPR04MB8016.apcprd04.prod.outlook.com (2603:1096:604:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 02:34:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 02:34:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chi Zhiling
	<chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 2/6] exfat: introduce exfat_fat_walk helper
Thread-Topic: [PATCH v2 2/6] exfat: introduce exfat_fat_walk helper
Thread-Index: AQHcwabpk65y6NPc1Ea3jaMAZ/dk9bXMnK+Y
Date: Fri, 3 Apr 2026 02:34:01 +0000
Message-ID:
 <PUZPR04MB6316BFAD68CF7BCCCAFFD4F5815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260401071138.114836-1-chizhiling@163.com>
 <20260401071138.114836-3-chizhiling@163.com>
In-Reply-To: <20260401071138.114836-3-chizhiling@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OSQPR04MB8016:EE_
x-ms-office365-filtering-correlation-id: 2a2ee792-a99a-4847-de45-08de9129777a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 sfR+ISnslNiGCGecfobMIhLkmW0NIufoeRwHX7L+MnY1RWkoF1Dy8s6grW5ICOcEMbmP4S5kqa1wGp1csb0ZhZpbfwVX9tMrZfl3daOjKyyb+cR+t/5WM/MqErQkcFTaaKdj/u7Uqb2rAORWDRZSrE+ktLaykZ5lAQQyaX3EXzjsEK/kG+D18HHL3E3VTH6RxDj6UBSG5yWoX7WKBEzQ5aLUHF4j6KCCcp8ELVYWKOLe9sa9OW/Uys+QgYIRMJYKtY7WZ3kOVidrFkaU0yKg+7wklpnXuQKkJzuywP/yZ7iRYoj3cvQ0PPLPHtKjbhvyEuWP5j2qVnIo8+JRn9KnEMY3vKtG5Wvs/HLwGJuL9kW3/Wa1mBbXcQQM8Ia8sDdG0q+u0RJ7iAw60cACGPdqUhyKEgkRRAIkg+DnQ8IUtOneyq0fiUbD5QWgDkqyPpO2Z1eedjDDSksQ/QB0puF3zNoHk3cMQH47HtfrxYtSv9K7d8pmFEI3YdMxJfV9or+kj5dKebO8O8+W3mAFTCpdPk8pu1aax+B1E9l697iscaq2FidY9LPkkyXF2okjxa2sM0V0ie8k5FXtUE1kOaYPD2dFuYgJDrw96Xj/Z6nRIHagpVzmvGzDEAEgfgny7zGQN7fp+IiSvLkzljkqTpw2hWZwJ2mgaragljv4ju707abv4IU5dXd0YunPUjB2xbi5c5ZQSEtho2GWPgE7RoN33lkle5MEbAtfNBE7VB4ZsqLjdCDIRwHcZhS8JZieOsBQGJ8sNYofgh6xc3pbGgnO/QKewR/NU4FQRC982cit0Q8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rc8GdHMHWQi2Qi65Mg3yJnUTkkKQ+2VkHTs4GaGZhJgLtf6AScrvNhU8KC?=
 =?iso-8859-1?Q?Uxtb03Lf0eAPt71eLDJRFFa48+uM9r2vT2dyae5A51fvzv2JyzGTxcriEs?=
 =?iso-8859-1?Q?ShEIJpg9sPkV9+m3Dr1jjAciiQ05KqvrIIWU1P/esRYKZ4kqG8zAFeNGzf?=
 =?iso-8859-1?Q?6A960zSeMznz9d/5e/PXVlcXZqmcMRfvV7W22cUPNxzs0FlzVPwuWPBZ8T?=
 =?iso-8859-1?Q?aV7BsiVWknQttpMXCbDo7DTo1E3H9gaDF2FENLRq2E6bUYRYlhsgcKZKZB?=
 =?iso-8859-1?Q?USB1g2h/75W77vkuEZb+yf8tHlSoEVWja5IxA9aXCm2uiV89ElCQGcB2NT?=
 =?iso-8859-1?Q?tOiXtnzK7+6RUl4TO+vh1V68MBD7WXOLbRqEEni0dobCpbAOwcA5giJiP4?=
 =?iso-8859-1?Q?UhOy7/iM9zAwahoMnJR2y+Jbm64TDAmpe3gx+gkrar9TAAAcnUR4eCmFbX?=
 =?iso-8859-1?Q?UxCpkgqc42wuryf/dICqbdMYLBKflPGv1d6q1mAabo14FHrE+znvj8PwzL?=
 =?iso-8859-1?Q?U2FAxDUY7wTVBTSub8og5sQ5DcGoXfDA+xV0SmHQeU+c03kclqReBZvRzB?=
 =?iso-8859-1?Q?QvzyPODGjCuFUYp/7ZZUkFx83Dn3FlTaPKGtCkG2IOhOuee8InM127fOV0?=
 =?iso-8859-1?Q?bLr5ZjdNix9oa726ojpWHDNvwMOAnjaFYx1DTPvXdOGv34bAsirERheJG1?=
 =?iso-8859-1?Q?GSX1HDwXCcMTkpaX85nVSV0QWZ4Ji5WCeXLvl89cmVt/emYXOewKTeAf1F?=
 =?iso-8859-1?Q?ZCd235nzrmHFqkHOhXS5Pb1zNOyMWCyRxp7fGM6/kieDmoZ43fN0rv5XMk?=
 =?iso-8859-1?Q?8ujXZrQQ9d4bWC0tOlJ1gRMw8zU1eK00hLtV4dOXUDkR3hCeUzN0cQxX2Z?=
 =?iso-8859-1?Q?qDFv5iFl/bXTZnu4h2oc3M6UXWCakdL2QFQvVnZMFqOKTJw7+KTMsf9rIl?=
 =?iso-8859-1?Q?kifsqLNd9QT/m/fAbysYftLETKABrS6OV+91TG+pL0itK3oVpZoUlbqMmm?=
 =?iso-8859-1?Q?dfAOzqjrd+SvoLkedhZ6Et6MBMp45JaysNkYTW6vG2ZdNvdsvhRSRKsG2Y?=
 =?iso-8859-1?Q?6azogUDaMzkqMV0CGu7Cx73kbkxzj9C8O8DS90U1CcffHf+e4XLNv3su/d?=
 =?iso-8859-1?Q?1xNclJ412naZXyzm9kUu/gLTMHcOjG2i82GwHiP+tVJ3UG7SnuYhH+EsB0?=
 =?iso-8859-1?Q?+HcMf2t+Kn0vWyXdPWmE2PRHeuIuOlIShq/EuhIgk0GdEjHfo5mTB0DPSG?=
 =?iso-8859-1?Q?CxWjySddRwvxUAXaBzuJXCoMOcNTvDf3hLWgxihBO+zCV+LmrQ1nEzLQRb?=
 =?iso-8859-1?Q?Ncd9gORYMVLvn1TZuIxkhJ+i85xMOr7JMYRqGlfXNTZlmnv5MEkDdf/7Ir?=
 =?iso-8859-1?Q?6olfV4iAIZwS7AOTcdxBjFGadBkbFYQVDK1JcV7LZkrRWWLWCD3CQYo6HD?=
 =?iso-8859-1?Q?UQB4NFQppkER0wzpQvCT7DCMnNJat3SQqWRlCpYevsgxwiQa1+vUAtrfxH?=
 =?iso-8859-1?Q?S+dmXoQnS5VJtlbpiMyfWqR4v57ks4yGtoQKcSp2Ex5FZu7+//ie3KBNnG?=
 =?iso-8859-1?Q?9UkyIdTAn2togb7uFaLFfao9GjpQDU3dvSNqL/w4a0kjn9q+BjqO0O+HpU?=
 =?iso-8859-1?Q?gDib6/kO0ePHRs6Kgb70khz76vtwSf3WCDHQnAk/Tl6iTQjbJbB4R8VOV9?=
 =?iso-8859-1?Q?nVyedEgm4oS/VDj/H5GNgGBHy3BgaodJ1P7WE+tZ+ZV1jsV7kSKiJcB7bl?=
 =?iso-8859-1?Q?uh06ic4VS4yrR2c0hjTPlDOGB8VCsImAo6k09Zs8z64ll1zDXKBcy1xYWl?=
 =?iso-8859-1?Q?ABjFUJ++iJ8L+0DOiklOOraeHb6Eezw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tPZP2EoaTuqIU2UFq9miI/VyD8jU8u2s1/i4iJgaTr68b6WJ587hqWeAIv9KVQ2A3aBETRItC2fpDqhv2ANfg9ZSVxxOrx7/um5El1L4poAXm6o425FcW6ZhqooBFuPefOhRjCdOdmBdu1NreI42VZ1Wb8aNoe8KFSAD12UE+7e2rBii6aHFWMpeBcDB/PsWEMH2BJyC9Rzs3JI21si8TdTxJMcP+86WRScyQxgVpiP3PXt+zo6JGsoZQuFaLRutgLbIFEsKGeU90NjBv5jzkvpSB61GkbC6u9SAZWwjptTzHGYaIK7M4j5Ov0BhB5rH0S5aHNzzNP1xhMqOxP7wTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fYIgzm+8XD/NWX2NeXtLIcT5CZLmJ9DK0cp5MzOTuf+mrN5/KbaiUOtA/WSMiS6ZbolAKzk6fQ9XHsqU+F3S0+YOfW/oADGQXhE5HAQwT00tsO9OTJ5shYwg/rlIG8UoDjF7QWt1fsr5KEE9fmjyEGN25plFlzGzt1uNXzRFUmJJ6Yt0w953bpgOCLQI3a13/iZIzqoPtAGFqLc7ipsOo6jqtIt3V+/azMKRCFP6sFjBJfCO8y6IIm6U4FRecH/LXN1RnSOu9l+WE2nD8HD8rcomXU+a8FewAYAjP3+jgwNyIyRKfDoFJE6E5R4G88BI5s/Zbwqk7NWxxKuNf+yFM4P4z6HVc7n1y3MhWNPZNquNqgktGCA8EXgfVZkB5KfhcghVHQ1RkLLSGJZdZ0rzZiowr4kmuuRI/neartMBUctTj8KzuBZFDH94nZtQ2IQAlQVrEJnYzk8sGB5uLJqeNK5goBMoLdBCyIS6aWzZ1fSxG5BHeH+vdfM0bfFzkm50V9cnngTFin/8MZ/EuA6dm/GT86kfHBStkFlVZoDp7bV0NNZ7a68wvdGSP6W7LYHZQv0lNfAprDbPQNuYWAL/c5+DdVrFSyQgH9VRe1qsjXKUpM0aa29JftA3yh+9pKmK
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2ee792-a99a-4847-de45-08de9129777a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:34:01.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXxXOnIC/96JM243MYHwGmF5dmS2GUwi30+qjQYeX24XVe0xzOAi9zFVFDPdP38bHoXHUBhvV0BmeMBdu1Nz9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8016
X-Proofpoint-ORIG-GUID: iQn6QH6XFVT7sVdpmzTsy7C6SlDz7QLo
X-Proofpoint-GUID: iQn6QH6XFVT7sVdpmzTsy7C6SlDz7QLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAyMCBTYWx0ZWRfX9VXXASWUa+F9
 0ExdFL1oC9P3pQ+JBKS2hvVMrr/44y6Kq9Ql+nSv0odGvb5MKOjnAt6DJgYc4jzBPq+HBQDinhl
 qRqsJX7fz1xk5lxULVuCg1x7FFikPW42Nmwej6PDoz7S0R8mkVtzAsUKq+GCazPr1neLsUdfxvf
 EqWRwy8rgdW2BmcFG7PR6l0c/ww7VbuoJlSTjH2B5GwpR2IIhXu2azQc2LViVq00RSeCTL/PH1+
 lcUgmjjOANYyQyUDA5N6/uSQe7JYEEziWQh72Oe4Qro/jZcVVz0CwWMxtvfumV5odBegTB1oxDd
 jMn19IxOILaJzpLs7UsKvE1gCbWDqThUcJc4o+08mTocH1PaJ5ipwAOfVL2hmGK2pQZlQd3GG+M
 RG5Um/yalOsOe32rPibbRkzW03+cieb+JOA4z58UmtSlWinVk/NYBmoccUlPMLELLaF7mkp4oOh
 ivfjB5Td+sPDWwL3XdA==
X-Authority-Analysis: v=2.4 cv=P+o3RyAu c=1 sm=1 tr=0 ts=69cf271e cx=c_pps
 a=zf1DDgOLkl6lmOu+DMpv0g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=I_Y4LlEPCAdqsIK1J1Zo:22
 a=_5wDq3oktJwZhEQOXGAA:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: iQn6QH6XFVT7sVdpmzTsy7C6SlDz7QLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01

> From: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> =0A=
> Introduce exfat_fat_walk() to walk the FAT chain by a given step,=0A=
> handling both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes. Also=0A=
> redefine exfat_get_next_cluster as a thin wrapper around it for=0A=
> backward compatibility.=0A=
> =0A=
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> ---=0A=
>  fs/exfat/exfat_fs.h | 23 ++++++++++++++++++++++-=0A=
>  1 file changed, 22 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index 9fed9fb33cae..530459ab9acc 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -437,7 +437,8 @@ int exfat_set_volume_dirty(struct super_block *sb);=
=0A=
>  int exfat_clear_volume_dirty(struct super_block *sb);=0A=
> =0A=
>  /* fatent.c */=0A=
> -#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu=
, NULL)=0A=
> +#define exfat_get_next_cluster(sb, pclu) \=0A=
> +       exfat_fat_walk(sb, (pclu), 1, ALLOC_FAT_CHAIN)=0A=
> =0A=
>  int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,=0A=
>                 struct exfat_chain *p_chain, bool sync_bmap);=0A=
> @@ -456,6 +457,26 @@ int exfat_count_num_clusters(struct super_block *sb,=
=0A=
>  int exfat_blk_readahead(struct super_block *sb, sector_t sec,=0A=
>                 sector_t *ra, blkcnt_t *ra_cnt, sector_t end);=0A=
> =0A=
> +static inline int=0A=
> +exfat_fat_walk(struct super_block *sb, unsigned int *clu,=0A=
> +               unsigned int step, int flags)=0A=
> +{=0A=
> +       struct buffer_head *bh =3D NULL;=0A=
> +=0A=
> +       if (flags =3D=3D ALLOC_NO_FAT_CHAIN) {=0A=
> +               (*clu) +=3D step;=0A=
> +               return 0;=0A=
> +       }=0A=
=0A=
For ALLOC_NO_FAT_CHAIN, since the FAT region is not accessed, it would be=
=0A=
better to use a more general function name, such as exfat_cluster_walk.=0A=
=0A=
> +=0A=
> +       while (step--) {=0A=
> +               if (exfat_ent_get(sb, *clu, clu, &bh))=0A=
> +                       return -EIO;=0A=
> +       }=0A=
> +       brelse(bh);=0A=
> +=0A=
> +       return 0;=0A=
> +}=0A=
> +=0A=
>  /* balloc.c */=0A=
>  int exfat_load_bitmap(struct super_block *sb);=0A=
>  void exfat_free_bitmap(struct exfat_sb_info *sbi);=0A=
> --=0A=
> 2.43.0=0A=
=0A=
=0A=
=0A=
