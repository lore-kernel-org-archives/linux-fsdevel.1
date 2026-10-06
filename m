Received: from mx0a-00617f01.pphosted.com (mx0a-00617f01.pphosted.com [205.220.165.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21C4A2A59
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376432; cv=none; b=E7TR+/Q3+80oUskniW02pN5C5FdHLSSn9YDQMHi/PfQlc5xhZo7kLwsq8RbWbQJRRMTdxCcvj3TvBJLhxhjzDWRiHwwKjznbwq920xZiprhu3HZ5e9NYZScL5AoGMmNcyzQwBUx2skzXkOR+3lLDHIgGK5bPnNTI032r4XiaQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376432; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tYJJxm43Uby27tETAm1Bl9wcnKHLf6L4Zd0JEfiNQgKlBony6SZRlbMRoBkE2Szs9C1acobqKr8aV2nADfCnBcFuU1/KjWvRgpsjBv/hDp4/TMnPMQqx2uekZje4cI5T4L6jY2YTOjIFMl2BOqMxM+++ERfwt3NzHRKh2nc/ZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.165.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247527.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69700Gde3310426
	for <linux-fsdevel@vger.kernel.org>; Tue, 6 Oct 2026 20:07:59 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5b5e00pd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 20:07:57 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 6 Oct
 2026 17:55:51 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Tue, 6 Oct 2026 17:55:50 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <linux-fsdevel@vger.kernel.org>
Subject: fund transfer opportunity,Reply..
Date: Tue, 6 Oct 2026 23:55:47 +0200
Message-ID: <20261006235547.E3FB0E0B725BA0D3@psmicorp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: OM5F-0E8aeO-ZCwQ5IEudtVaVt1yJEtn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX3Nf1UxuYymkk
 zXPm0kXTqLGTPlcz7OXafKKtxyYiBV/raRNpvm8YYmTfc4+QQzpSmtTgH/XicE6yhwILkZ0HEPQ
 iHOH2GM+xypoZP2Hz2Pgyd6NpFLJ3bWixv6bTqEFG3U8C3R7Ku0lw13UhUOp0zlgzkpdw5WqbIP
 MC4upubS1zQeuCrDLPdhEh1Osw+RzoVYHmsY80wvczHDBMnzyRO5S9PjIDdU7ubycDxlgLFTlLv
 mDm2DUoC1ZTMH54dY9vSXOm71duR3hUbg8TqL9G3/Q8jBTOgJH7cYMXoCnwIbk+Z4H7pvF5+f0D
 2SPaYAeo+5pVvZYereEntBldx8K8Ct8APZtDR3tybLHwaQvOAZmW8G6JoCCFGZ3kLvnHMpDYaAk
 SHO9OGmWgtF8sCFD73m39HRzxJMRNTeIsHIgkBDS7Bgppd9STESvxfNfRjOd8+9V3wXZTQUjfXI
 VhdZGE5IJ/APcyydsvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX+hWcU1eNifiq
 zMyCBjnqXUhd/658t4/TCcQ+FdrkTFluPFPEVVTjROv9lNijJw0R/mF6KKtRQ0/YtR9UX99CaZW
 gLoHbueUWQdrH0YgaJDhoozAJb0lbtPyD0THjCjLtWrm4N7q8y9i
X-Authority-Analysis: v=2.4 cv=GvTXaU1C c=1 sm=1 tr=0 ts=6ac58d5d cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=GfZueQGhKz3ujf-POmTq:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-ORIG-GUID: OM5F-0E8aeO-ZCwQ5IEudtVaVt1yJEtn
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070000

