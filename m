Received: from sonic.asd.mail.yahoo.com (sonic-euwe4-0022.asd.mail.yahoo.com [34.2.86.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD29572673
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.86.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961182; cv=none; b=jzgG02UyQ/9Wr0S1qMdTw5MtaDd7TrddaoxdWXcpyTSssJ9ePQz/W+sP38nAnMGZUgK+G16iUElIG5wxHld7htZQl8DOUtMfhrK1WsTIxYgAnd3qEykQO1nFXEq45HTxfnm2ZXrx3uP4KSQCqCuY4obo1R1kEslqlIdP+rOSaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961182; c=relaxed/simple;
	bh=nz7BXI2m4OUMBVlwQw5x52ctOEKxWUoEVX5S140EVnk=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 References; b=WEgxYzAjIPY/+CZeFfGw/A1IQPtxrqxvlf+0R3krASx7ZwJKL5gVKTMS1uMW6SleovTSQg+LenpH5uPeaARNmoiatZR7UKS6qKL1I9sMdtV98sfkydAWlk+pGMcSbyK5OiNJqJG3KjZlZPYit0t/ul7Ivr9AN5QTXOc2l7GApgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IFvxtIX4; arc=none smtp.client-ip=34.2.86.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IFvxtIX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788961179; bh=5kN0UmcpYYHx1crM6iPhg7hzqy9R/0GOIEVvaTQWXD8=; h=From:Date:Subject:To:References:From:Subject:Reply-To; b=IFvxtIX4UNGrVqb2cAMTxSxGDKeJEzNNL7bpCKev3MFCnJg9iv5LOYC6yjcUJT6tQqyujca2xmN+p5x0WzC/qDVCzZTCXB0n8VBI4rY/eTpXV9MfI+pKrjsYa9fwwUJbMKmYWHrTCvZ56pOmQic4h1Qk9LiBnml39byXCEgXnBttZRnge0ApQEMM1UCtGyJQwVr/TpOuoJWKeRE8ygqFSEXSc2od+YrDhw7K1sxP0xEm9ncFifC6B2bYj+LXo1L1m1YklTphy6q0sd2hZHh1vq7O2LNBuxOb9/B0ggkmDsmKA4Oh/wo7IrfmSfXxceEQeKbhJqyfRdjtqQjUVN+u2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788961179; bh=4xr0iCuCouMr9SjuUvW0CYDYN+yXzkP3vNiBTInRNiD=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=fJXHF1+fbBIraTqRrL+oMelGYl5OkWy957FegVeZVIYpVPpKkKd1/ThsPINSitHur9Xie1pcVDJenyUMDHYwPcKi2t6crVB/rn/WUV04+PPwFdl5vp3N+PGUOvEX3js2YqJIcZDZ0ysVLo6oVs7wsRmdKrUFYvECCRK5/TXTIVLOw7EKLrs9tAC8w0cy9saffqQKyWgDQqsgODKGbmaB0NgtKnvxTvAPK8W5YEaDJTRlKin2UOMn353Qb9roF4+c/Z6YhQLIGowFqd/+4EXHp75tRf0rPM213/zFagKvhBagrzHAg7a+CD2aC1aqwxf1BCjYOHrf/lOCvUB9p6TXyA==
X-YMail-OSG: Cy3xC8sVM1kjuPdz42iL.fNvhgiuGEX.ZXOgmnXNTq.ERJpIw0afJjb_hDO6hcg
 RIEawo5SZWVB0N6P4i7UfkcqviEoyl0vt_fr5hvvO9TxbUgU_wwkU7x1svSX.33XSRfIjTsd6BBF
 ogumpih21ootyIVr.oghhX75kFUWV_dHUXhgTVgtfLhxjf0HaFgILTIwBa0XFLFOXg5drQpu7hS3
 elA1OeME57EEsPmStzsA.JyPwkTjBklSUur36S5Rr6qhlnKz7IeaDB9YJUT0w7aNRQepuA6NxKQL
 b2j032cNdzTTLkP.e3o.PFapB215RbRhQVnGwqSBbsiYJlICG1fDPFGeE0edGDRLDOiwiYq4cyPR
 H8wljhqWBji3cyZh7_ht8lICwMkIhMY_pyLQke5aeq9t4j_QDu1SDcn_zwTHjo0mbuvXw2jyTNyT
 4HliEiyKCdKUhAGu4V_C34xqav2i9jQt6v5r_PC4uCqsbYg5UqkEl1l3htoMzg.KGwK_tt_7wA.8
 Sxmn.NHXZNl03wimbf9w2pW.oWjvbXZ_5NuThvfc08RzLYjryVIaDp6ZGX74gree131pNNA23KFm
 zg_J4OoZ0yukmpxHqAZ4L6B6vRclP7blgOHNMAnHutcrg6gWgkso_cPado6FcNv.vOs9Z2EbrVX4
 0Cw7Zn2qurDrtBhUX7DYAEy23WYGYPbn.1WzzGz2DavI3k72I1H9wbGDe.7ocOf9y1yhvCldH719
 3rQfKU.k_CHqcN7JGpZz3cv6Jl_lZyGegYUAJfMeHPzTvJdRDo_9dtaO_wKJIraBeoGz1UP41ZKe
 cKKWbkJq15cJtkQlZxmKhg4fYis7O2.O5jtqziUL6QPOzZHB3Ga8c0SKj2NaPHe24d3Twpk2OCbG
 gTCIhij585PZqwhAVua0eonEaJcdkc60gRqKdMDKq7tQNEHYaRhegtsVMFOL7Pk3wFBsaw9RlfR5
 qgxsYOBBviQhOM6rCNpKFnyFF4V1enuUils9jAQawmsQZ8Z3SvPZoB8RXdWdFT0B_aHPHGmwDH7E
 MZFK0HOszLADSeTpZia6JQhBktQJ3Sa.Iadn6rMpC0XQVmGMjEz0Cg67pi5pOo57l8PpjEVc80SM
 cZVFtwWD_a1ByG2p.vWGN8bPd.VaO919DlTZiY3yxmZGonfQX7o3k4sXY501wTnosMXuNnkIfGpt
 Uc_S_yHa.v5qHDajDJfP5aszE3iR0XIf5bDa7SdC7GuzDDLNDyyRWOzptcDdURc9D.7A0q7h_N2.
 DCm1NsNs.AA66yH7FBYWIu93Mvwl7z.W7l2VAlgNCybA6tAssaTGYBXcE60lokK8Kcvn83fP82qJ
 MtVR9dMejqmOoEoCbaJB3Nhya13cInOHq4WVmTJxUiehTbqKS9C4uTtcXq80NBsdyNM64H3jlG7w
 ZkVQafMV6PSBt_8Zh5sojgv0.AENee_jTaqgKkyumGvC4IQpRfMNgg2BftilHlFwvl.4Npdpqbk0
 l5IVrvT1p8oRBiaosMcbfaQvTueX09nvRsjUIZ8Cwgn64Lr4TRVOYjt9wq_C5hQuu0I.O0pUET.g
 DLDmHqhfnKfhTKNliSnsOyKAzudyxjFvClpKD1AKMP9tgSxt99F.KhzoYwGm9D_VPsp8B7CIQQ3D
 H8vg4Tbb56ZnVIVmTuhF.rKqvRWJwkLx5scdJl_i1wMZH2O3AxunqEFwDuKT.PzArHwcK2I3jvry
 v3TpfBVb9D4v1mb7XNKxZ4F1P1m0SF7vBG6EQ_mNbWzPLgSRw6YrbDU.Uliy7eq9FzbRmo9vpsvg
 9U_yQ8wK1w7jrltRTcI8xw.3WalyqRAc.8W.eF260SjBm24uyh6qXlkk7ZvP5yL1gNFoudwCI0QE
 cBwA50940HWZvO1jDQWBHJmj0JGpwvrI.krqubFMY7LOAwnOGDgSPSRANGykoCM8s2Tib_01A.v1
 n83pvR_W2Md5NTmh8BYR_UlgTO3cxhDv2af.sCulyeOpHpoTyQhUiDZlVUEDXHMhaAhGlKEZyUEK
 9PVO8NGlYAYZX88bJLJGCPk9WnzTT
X-Sonic-MF: <bilginaksoy2003@yahoo.com>
X-Sonic-ID: 80cec75f-7bce-49db-a6e3-0d50cd51c96c
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe4-prod-sonicconsumer-svc-102 with HTTP; Wed, 9 Sep 2026 13:39:39 +0000
Received: from dip8.lsn.ir2.yahoo.com ([87.248.99.17])
          by hello (SMTP) with SMTP ID af061a0f37413227cd8ad28404ec07f0
          for <linux-fsdevel@vger.kernel.org>;
          Wed, 09 Sep 2026 13:39:34 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Bilgin Aksoy <bilginaksoy2003@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 9 Sep 2026 15:39:23 +0200
Subject: Unsubscribe 
Message-Id: <C38B6A04-9ACF-439A-BEE1-B6F6AC21181F@yahoo.com>
To: linux-fsdevel@vger.kernel.org
X-Mailer: iPhone Mail (23G83)
References: <C38B6A04-9ACF-439A-BEE1-B6F6AC21181F.ref@yahoo.com>

Unsubscribe 
Bilgin Aksoy
