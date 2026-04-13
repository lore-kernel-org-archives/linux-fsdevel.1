Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571131E85D;
	Mon, 13 Apr 2026 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083335; cv=fail; b=NcvtEubUw6iPJBdh9VfVrlgoAgyz3pEpTPc8rAiBsSjgrRiVAXjfXCzSs+hwqE3P9kjNllew52UqZUvLedZAYkBGuJTtAJTsN332O/0CiuG82ouBM8367GjCBQFiX+lp6pSMSy+mHYgd6fI1WU0QGU3j/uAo77kCmFinTg+TNvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083335; c=relaxed/simple;
	bh=k/aNtxIA+wgrqiwNnRTCX/cWC3OzBlklNNTN/GfTI5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+HFfuu+5QTl7YvFp5+FrpMG4MYHxLdOsTQaMjeuL33nAYv1GWcSKolTo0fRLosjfBcKPv306tYLsSJiBtJxiO/eWkbRTb59tTRIB8qKVkg/0P1SBljBUr1lhPVg0umvMQmAdHdGkQ1q4L5YePaFBUX/2pMJdli0ykrx5NqPFMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OszP8mxc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SfTlaW4s; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OszP8mxc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SfTlaW4s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776083334; x=1807619334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k/aNtxIA+wgrqiwNnRTCX/cWC3OzBlklNNTN/GfTI5c=;
  b=OszP8mxcjo2vzyvLu+pIsZQ2DkR6wTVVEFa7M6qIWVZgB6cfMEvybKce
   saz9Rt+rMsqIxyg1Zan0ka4oG/ntcPkng/Q5Yj+1IC1Hwkm02CI+G+zh6
   zCushi7QUYAjdr/gazf+FI4HTJk5OsBhzkes6YB07ULdNZ6qthrRzJg7Z
   gVZhW2WSVI3xadwTXoSSELR/9Wwp7LcbDfG9UsuBnKXyrpjf13dokgMyE
   2vzfuFbQ0oppUu/xvj85LMiqHggLstqU+eXCMNP4XHtbZTDtd8pHNNOtV
   O6Yza/3FVu6cHBCsLEH75xzDFzPAt/wBFv0ScpR9OuABnJrfQ4l5eymVA
   g==;
X-CSE-ConnectionGUID: 8/Q+AttPQ3WhXWUH89/aWQ==
X-CSE-MsgGUID: mp+ISHVTTVCP6ecenYIzwg==
X-IronPort-AV: E=Sophos;i="6.23,177,1770566400"; 
   d="scan'208";a="140672291"
Received: from mail-southcentralusazon11013021.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Apr 2026 20:28:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6PYt8EN6NtPqh9ILWMQ93wOo1pEMHoY0g2IfmSiRRvNuAD/qgg1dGSSd50krFza4CbPdltXW4IaA4LmIHUVaQtqOjXMFJK7C6GkCmjDySGB5UkxYdKES4RTu8GaafFA2pS6G+gKhQMj1ny7+kLtrYR8Cy0Azvf5cVqCJDzwI1wSZCkUwciIwan6g5uu3NUVSzzzucR4wSvs0GkhJbTueop9LRyq+QtbGZBzQ0UVb4jwjl6fmKLHzum++T1yIJRIMeMj8HgjEY2r+Sav3dXR4MuKqQEYBimUbrqaVpUrTKrUK1g4tJcGOw90FyVEqIz5NswzwgLTd3J2GkwTPxuumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/aNtxIA+wgrqiwNnRTCX/cWC3OzBlklNNTN/GfTI5c=;
 b=QSCQvePJ0Rb9ZIzvOKAcy0iQgNrJb/AJfTLp3o+bFxjI5dh8B1zymms8OhYLdzFJUCz0cPVIbbyPEwwNsW4OGFkHjX6MEGUF2LJnSRvRVakS9kCRDgcJ/ZV3f7NrDVfsFYUZDrK7gVGLvBs7OMddeHr+LHSQoMIMgVbwc+7vCIxvvAdJzL0ZaIZcXsoZfdMSBF8LackeGOgQoH5wUpmbPluaiU/2BPtBoG/ldBR6wy/2VuNb0947A8MnzLBkp8xolmufxGqin6+qkh62Ke0RdENPEFiWqapE6rvkvOeYwOtSvwK/wNmdvp6kf0mAIBDd3txJ8uKS9oAFzHR2boze+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/aNtxIA+wgrqiwNnRTCX/cWC3OzBlklNNTN/GfTI5c=;
 b=SfTlaW4sn0ZcnE8gPtv4JXYu6P2tiY4JIfatRG/n+Z0SANEaWjCEw2Ybm9LO58mAD7OFkQemtnuRs9oWLch4eCve5lEpwfHSOIE2D8YUVnfyQCBwgzzAfyofbMWxz6Brq/glVgO01k50Cs/aUlew7rbkr/Pl6OIUIIen54kpwA0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7344.namprd04.prod.outlook.com (2603:10b6:a03:29f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 12:28:47 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 12:28:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Lorenzo Stoakes <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, David Hildenbrand <david@kernel.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Thread-Topic: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Thread-Index: AQHcyzRf1umTanX6k0SRtLxnV5dLI7Xc67uA
Date: Mon, 13 Apr 2026 12:28:46 +0000
Message-ID: <adzg2DWDWDR3DFJh@shinmob>
References: <20260413105713.92625-1-ljs@kernel.org>
In-Reply-To: <20260413105713.92625-1-ljs@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7344:EE_
x-ms-office365-filtering-correlation-id: d86fb260-249c-47eb-592a-08de99583575
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 2IrLJz7UC/QR28IWGwvazifHMhsScPyxFHwncGBJU0iTRm93ENbJ2LSk0sd/s5krJ3l0L9QH+Y+aL4DZGx3g3kBdXoMAMFDyw2UIrEmh8nzzXf+Vz9E8EdpW7AHdQ5rebxxM0P93dSnWY+HL0X5hKiOYOIUGqyk++egsM4Nr7jsC5uZ1nr9uJDUXXLbO9Y3Aqn1NUi3xXnI/P/ayNs9fpWQbtNmQ8mfCeQU2YQPcmsyhwf6MBTBGL35o5iW5bAQlG2yiSL1Kzbm0F9Pqmn1eYsrRr+Cr1rX+zvvjKNjVe1TUyif5ouizAwbvXTEuQ97+P735hyNLhA+pCGqGwNA418TiUgk6dZNCVj9irp6kGWT3KL5K9m+mDU2q4EHYHls7Y5Fv4alsqTS1IDilaSIx3O3WVim5yUA9DRR6p1QtcOx+UmN/fnM4EJpvH8BteBZhmDcbq7xD4niQg/sKyspaYzCQz0wSm9VzytDhrlOPHY/CoSAEkb5sZwDBQsl0KSYSdgR3iWPVZdsfPuf2DnOztD91vvCFBHfo3UcNa8zdZhV2F/LgHlRxpsfkHESQX/KRNo+c4OTv6eoJCs7jpCFQ9IBwg3PjfFzKv0OxbqxqXh4UhdoWsU0WiE1qGnydYKlqyV04qPQ83BRVbrrEeIvCjWYjwk8j2p+zYeskvfQjR4DiTsvLeizDNkp/g5GYiTM2STFp8mIt1YamSwzMIHykmNel1mABqh9iFlY2BwMlIwUhtM6CfN+XLgXyZjIGZ121BI4UDTzy4xCDeJB5hn83mN/TE0vfqiyrJJNZmeIy1Xw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ehnbxeuEjhgOSuaz7SXxQuJ/DWi70L8UXdeKeHLzk8ZFpk8t0IVyiTtGrPBr?=
 =?us-ascii?Q?dLNktBP8AdQ+mpVZqzSb73RethmzHfkQ/xpACEbFfIsrwDfZ6wRuq59XyWDW?=
 =?us-ascii?Q?aTmP+o2XIRD08MZVdGg1vnIkVQqJelydHWszNa2QAJG28KXVOaN3bM+nk4rX?=
 =?us-ascii?Q?9EF6md7sMp6S2WUpUGboIpq+8dlflwH9WNxhY3kKthihpBmAB/Fy3Poq5K/s?=
 =?us-ascii?Q?QazNl6crDoC1DEoOaJDI2Us/p8K3oz5sYJEYNjLwSFzSj1YvuDsyjwTZztGD?=
 =?us-ascii?Q?1OUS/87IcR4C5TA1J4xiJKWWIys7qT16M4nAIo627BCshwpTtlqAxXPfU/aP?=
 =?us-ascii?Q?W1lrdr2Ld0CWVgNqwXIf+WqAQQ+bRD9v15ADER1UgNdza59Umtt1NU9KVxrE?=
 =?us-ascii?Q?2pe//o0PZqnAlApWAFOt//ISA1hlapVR4s7+BKOVC9HrTJKUu6s3CbndAoQ0?=
 =?us-ascii?Q?Xm/J3Lik3p0fizpkwTbTd3g/8lNgZe37xIvWDn5Av9mav02QLoHUBfANOkY5?=
 =?us-ascii?Q?lBl/r1TPWI9pJmtA+Dpz8CyR9pEXONK88KAinbGkquidcIBrZHnjhIDKIy6e?=
 =?us-ascii?Q?mRsB5Cl/Y1Z6ELHCXgsDEQGrVaTOWj+Q9vCx340dLBTLympAPP08SEwwG96Y?=
 =?us-ascii?Q?ezLtMnHBc5J2Hd7jNUWqDmfu/DN+TkQV95Pyyu/1HN4ko+OjO/URywodFD+g?=
 =?us-ascii?Q?Hw9JaYD+2MN66a80PFoDJk5/W6RjoiMGMMu1ZPAr2b7XnhBxh0WhLNM+6WdU?=
 =?us-ascii?Q?7ayFX0jnsPgbUPwsyauyfZo6ALw2Paum6pUFo6i6wpp2Ea8J3ZWQkmw95z2E?=
 =?us-ascii?Q?8v6dVNBrJxaKTkGUfGjdv1j0JYB8PiKHJaMbRQrOftLGqfHTEErbvP/ILgNs?=
 =?us-ascii?Q?ZrB/iZXozdyxggpSOl7o1vg5ix5qwSeD5HemVPOBZipcYKaf4Ivtl9ZEcQVq?=
 =?us-ascii?Q?cMaOshE0tQpoUQ0OoXaES7hZgGKB9x1O1i3pSsDN1wwOgkPD5wNXHualIB50?=
 =?us-ascii?Q?ASNEClHQ4nFFZFPfHuBa8BJacYBggbZHis0zNf6CXH7YsSEUeMTnk3yM/obI?=
 =?us-ascii?Q?0uqc9sqXwSO74D4BRvYgcDLXzANEAczHLL9uNqhP6I0yjbn+GFaI8IKOOTss?=
 =?us-ascii?Q?7n3TFNVDSZstg0OAOSlcS02D73oGPiV12JGUo4aDr1cElXjfnTQuMzrjXKl7?=
 =?us-ascii?Q?xX+g9ROpurl+2YhaWfjxeERaHGy7hrDS0+WQFKrswXsEYwg+UpflnKLf7+ly?=
 =?us-ascii?Q?zJ1rGpn0MADODRHpWGhZ3c5LIjSZOgkQPshmd5Tyu4eeFE0oJYWxnTm6IRlf?=
 =?us-ascii?Q?qjv6WRAcY6yDh7WwPH7HMkNDgKeii2ovkp2k0WJGQNJSMQ/NaeTiOKgCmnGD?=
 =?us-ascii?Q?TvbDxjST3H7hsKqEdMojeZJWCpI54xLa9dQwhxL1S/D4f8HudhNni6R0U7zr?=
 =?us-ascii?Q?vUg+3qMB4Naife6me9VmxFSZDsZB8vrGXTK5LjTJ0YveEBJxoLWnQo+dVnhy?=
 =?us-ascii?Q?6GMqw0wWdWfgqhuvQc21Ly/ggMvrKCrTCc4Q8gRy++SqzJoWReK8YisTL3P/?=
 =?us-ascii?Q?Pjmkm+/8jtYG0EEkmg/DHN6kKNgZA9HlIt8pJByWNEAL3qDFR74lG/a+ml7a?=
 =?us-ascii?Q?Y/MU/4cC8npBHbRLeGrO4hqX/Yff7SDsGfWRjwrZLacLRp4teVDWVJNMUh0u?=
 =?us-ascii?Q?9Lg7zBZz8/qSkigr/mQBP5SAVdwf6lCK9hbhOj4TntNOtxrThntrt3pFgnVT?=
 =?us-ascii?Q?VofgMshJNL7JQ3vBr0Bfcr9/aBWNRR4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBE4B584CF734F43B38561A3B68255E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EypQzhR8NRe3k90dcAPVb2dggV7wvdSZz7vLDBHPFrdD5vvFsZjJN2bExQCk1Ih9o81RDH81Hj0ZVZA6+gqoAAxa00S6pmvvQ81x7zsNP7tTDkS60istwJldeU56yMPWQ/xzxNrgxk7Pf3PC8s5UAOMdWiItyWinqxoxvGXNsq7GzIlnVnawqjV0fJyzu//LHkQn2a2auZEeB4e1GkYDILKsbA58d0pPE6BeZ2fgcE5dGzgOQftSObbCDPSZ4L80kPkBWszECr1BB0PETJq9SN2hZDUjWeo25FNM9doJqKQxacPgjWZZLJV/+J+fu40WEN4nrFb5p+/dCb8/fBOZXg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T040UJ+a21xZii2YAWub/TRUXd2XlyxivkBjvXbbQLBuDI0Hszf3vsgJToo5/RbrtAQNRf/HcexqZBLsnP/uKt7ffc069Yi08hyvLWIPtG95EnC7GeyeEQydI9Ox0dcgheDUhQrtg48WH4yg4M63A/YNGsDEPkxPnhXWKQvvhaxUzp0Y2Znoyo+p1iPXXqs2bvDfxKN3n4m0hAknkQhRg+CKsVYz/mIhtTYNvRVTPbKXgvYWLSPRRP+kJx52P9t8SI2oJkDZs/3AZc0E8acTxKwOi107+G7/d+DuSs1uvyF5TmQ8JR5BPIovcEmCru+75UBnH7LeTmaQrEel6Uy1Fep9X+qjKcbsCxbccjUQtpksWC9PvgnQF14tR5PUDCacA0nNEZ6mEBoJoJDfCvYG5d/QGhY+5FvIcw69V1YTblyXXt3lc5b5qxZ2Y9Q3Jb7G5+FlvWg24bn1ADfVm2ze2q+MqsCwQyktn2UDMOlYWqncef0Da5A9eI2lRoWUNUJgawhxBcADSFrIEAzJgEFigC1/gD9hIOUiigFB6MjDWs0aOxO9TPVR7nXsUmeeMIrEgn6BmWN5ZY3raRDfENtt9Ua5x0X4MFquNM4LbitwhvEBVDbSmDwo+S0Ef4CGmeuj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86fb260-249c-47eb-592a-08de99583575
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 12:28:46.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gPOKzHCARUUvq6cWvIF5AULFcwUtKzfQRKNJyt7Vt9KAgsR6WbqVbfEgq+bCVrS3sL19XYElsRAOEJEcQguCb4G0wmuT4cJtsTAkRsuTXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7344

On Apr 13, 2026 / 11:57, Lorenzo Stoakes wrote:
> Commit c50ca15dd496 ("mm: add vm_ops->mapped hook") introduced
> __vma_check_mmap_hook() in order to assert that a driver doesn't
> incorrectly implement both an f_op->mmap() and a vm_ops->mapped hook, the
> latter of which would not ultimately get invoked.
>=20
> However, this did not correctly account for stacked drivers (or drivers
> that otherwise use the compatibility layer) which might recursively call
> an mmap_prepare hook via the compatibility layer.
>=20
> Thus the nested mmap_prepare() invocation might result in a VMA which has
> vm_ops->mapped set with an overlaying mmap() hook, causing the
> __vma_check_mmap_hook() to fail in vfs_mmap(), wrongly failing the
> operation.
>=20
> This patch resolves this by simply removing the check, as we can't be
> certain that an mmap() hook doesn't at some point invoke the compatibilit=
y
> layer, and it's not worth trying to track it.
>=20
> Fixes: c50ca15dd496 ("mm: add vm_ops->mapped hook")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/adx2ws5z0NMIe5Yj@shinmob/
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Lorenzo, thank you for the swift fix. I applied this patch on top of the
next-20260410 kernel, and confirmed the failure disappeared. Good.

Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
