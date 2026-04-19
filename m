Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B410F1;
	Sun, 19 Apr 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776559358; cv=none; b=lCjCLQ6DahYUTyKwPEdS9ttfXgSfnE2jzCGOSpD8GLW6Qq096l/WA5z3RnWnMi6ZnpgJtGHsdhxqNLQYJET8N/DDyBS2XX9poTW4iNd9HeoGgszXk8tOwuVTsb6kf9WGPALiMYy+2JMhbTq/UqkGwxq5ATrV3XXIq3h8nKDLW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776559358; c=relaxed/simple;
	bh=iPW/y5pADXITXht7iP58B8qisYZQ9v+e7ratS9msR28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IyCZ4ac9VFplX0o1DRKuWIdxJKiAumZXFHURvzoG/5ZPnUYlciHA63KlcD06aNZNXrhHs5wTOMSicYYmKmKh/dVk+uOeXbulankGEBXKlgQlxrqlSRVmwbs905P2vs8Qp0EqrbppN1uvea0MBBFqYk7oVYVY/Cklrfa2HXTlaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=InDvC6q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T70Sc35r; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="InDvC6q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T70Sc35r"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B85D17A0050;
	Sat, 18 Apr 2026 20:42:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 18 Apr 2026 20:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	ethancedwards.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1776559354; x=1776645754; bh=FlzxNUPIr/LWDRd9Mv/A76w6SCSznvhL
	IpTZq1Wlc/Q=; b=InDvC6q2BNsZI+hzzjyFI6soE0gAH2umc8iokMkU6odFCzPN
	KjRj+RytvS84Pc10X+INmmWZPVes6sc/XyJQSi4BCIC3j3s3YhNJbcaw7sYbX5GC
	YnzOKfTWkMiMEl7VVNmUiAc3+DqURowkDIZ1x8vSARKUnLCZ2TO3FocF0E26uufe
	HG8ByZa5waoBWxBJhfUvFbA/+Q47mxOd3aSevoTMjKDxlCtTKR2YxKtoboK0R9Pl
	z+OU7bB9227LzODRiLo0+Og9U1YUTlySsvtEtBurXopDeZyWa2i1DLr5zb9os0Pp
	KgK6aRhdL1bqji7vOHvjmndc8S4RJVNS2vC2jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776559354; x=1776645754; bh=FlzxNUPIr/LWDRd9Mv/A76w6SCSz
	nvhLIpTZq1Wlc/Q=; b=T70Sc35rn/5uK6WItPTxRtugoJdQaKQx7wnEuP7rbSTB
	8H6XjjoHSU7eaErJtpqBXwLQdNtkLrKv22FxlizcFt45iTh4eXfeDJUHaGhm5vCz
	TnyzfQlLNcwDmPvWzVpESB4Z+9zDCUlaMPGNpgl9l7+xvPCtJArV+PlKqoj1i+ke
	BnanXNnvez+qq0qSW0YkR1N0a+aP+RrMPT1agjjjQcgrGxZNpVzUw3u0Ups0pAX3
	rcOQ22AsTsJl1I20ld7/eRZ/q2mT+OTQejelbzxvlIIY+vVuaD3PXXs4BVdQMwKh
	n6qrFh9uPpnTjGO1qGtSmhfhlgGQdBL17kqJyhNyPw==
X-ME-Sender: <xms:-iTkacKjOsZ-hf8MOvs_97HtwejvahJXQe85SNvgySa5mPnYuekxmw>
    <xme:-iTkaWNlPZup8RrB_k15VERAiRzPdNHRbvX62VnKuYwtSjXlVQWarxx0b9ARXkFPs
    unock4MYftwzKCjy_Qvnxgd7S0w4VaX1UxeIR4im8PoSe6sv802S8M>
X-ME-Received: <xmr:-iTkacl4WQemBDKDLn6a-zflGyN4pZ6BQu_N2U-q-fpXhOIP_ysaOD2J7y2j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkffvvefosehtjeertdertd
    ejnecuhfhrohhmpefgthhhrghnucevrghrthgvrhcugfgufigrrhgushcuoegvthhhrghn
    segvthhhrghntggvugifrghrughsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiuefhue
    fhgfeuhfffkeffgfetgfejgefhudekledvudeiuddtffffgeehtdeivdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvthhhrghnsegvthhhrg
    hntggvugifrghrughsrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhgvrhhnvghlqdhjrghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhgrnhesvghthhgrnhgtvggufigr
    rhgushdrtghomh
X-ME-Proxy: <xmx:-iTkaa7-Ubl5opRNbK6qOSMY1YLVw4C8Anada2Btg-1B9gHT1w94rw>
    <xmx:-iTkaQ2CrtJayRBTaHJt94VU-ThxhMwHh-fWnAQ880u4sQ3NrExBiQ>
    <xmx:-iTkaVErChxdLfUCCn3lr5c6cq7vshLXyMvsuzSlWG7uagJjYCddXA>
    <xmx:-iTkafjFKWi3r5bthbdXwd4GDx0E8Ssf628mb4P33ftogFvhsiijPw>
    <xmx:-iTkafXnYtF6nWOoHF3kIK_5HrjXIBOReiZNLzawCyeTzsRGHkES6NOY>
Feedback-ID: ibf9e487c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 20:42:33 -0400 (EDT)
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 18 Apr 2026 20:42:30 -0400
Subject: [PATCH] fanotify: Fix spelling mistake "enforecement" ->
 "enforcement"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-fanotify-typo-v1-1-03ea48cb44ba@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAPUk5GkC/x3MQQqAIBBA0avIrBsws4iuEi3ExpqNhkoU4t2Tl
 m/xf4FEkSnBIgpEujlx8A19J8Cexh+EvDeDkmqSup/RGR8yuxfzewW0mqwy+6BGJ6E1VyTHz/9
 bt1o/6dDFFF8AAAA=
X-Change-ID: 20260418-fanotify-typo-c4ec2ad325f0
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=iPW/y5pADXITXht7iP58B8qisYZQ9v+e7ratS9msR28=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpENVIrZGxYUEhWRFNHcjc3YmQvTXVwajF1eHUxSnZ2CndKUHg2MTFBK2U0WFJYb3o1
 bTdyS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VTRVl4bit
 DbnFVUGZtVCsrbkdKcHRhdlhrNW9tbkZ1ZHBYVERSTmVEK3NuVkw1M0hIVlJZWi8ycWR6cFpNRg
 paM2xlSzZ4bjNyZnMrNFVQZHNzMGJsMEt2eCt3Y2ttRTl4dHpGZ0QrL1ZFawo9dFZVcAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 fs/notify/fanotify/fanotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index bfe884d624e7..38290b9c07f7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -457,7 +457,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	/*
 	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
 	 * Traditionally, filesystem return handle_type < 0xff, but there
-	 * is no enforecement for that in vfs.
+	 * is no enforcement for that in vfs.
 	 */
 	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
 	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260418-fanotify-typo-c4ec2ad325f0

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

