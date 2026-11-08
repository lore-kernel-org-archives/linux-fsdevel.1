Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177182;
	b=mNBlW/Z+aDC7rsKhplZoVmAh332PdHslTZFx1SeMbDnOcqW0wZ0ZZJhetKaZbnbZlyXS
	 H/+xSF2UURYBsXWOEDlk2SFUWptR8FfrPrQJiXyw5y19F62h3eDgx/DQuGBZsyVLA4jW2
	 WZBjVXyN+BaZzjT4diJ9dnDoVzb770gDD5kWp1NBc9Ntzh96wco1DqQsITDxS4W62Lw71
	 Xh5bLJVAveNdlyUMdhKezXDK6kTExwa9ZMu32OP00KMrl910elyK4IXXQFHQDO1ww3DZ0
	 epX8+AUt3MaTvptBGKf5U6swwkbVZYkQL5Lo03j9p5cTg2BEDuDcPHoNN0wsnbZPGkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177182;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YMj96xyXamRlNHvJIKz7F8bG9fRJ2XR/rAxoOAsux64=;
	b=tLSG9/UaJh1pKp2tV+veF87YlVjj19DkSM0sspRlxAN35rqM/oKrfzO2rDKjmVGjm/rp
	 /P5jPk2D1dT40GaJhayeNxuL1yQb3XOWF7yCZcCKqPRD6MHT4xH0fbnm5IyIvEKNDY6qM
	 L0mx2cdq06pzooXCb+UMoiXdKpBtS4N/kINTVreVJ0jxikn36xeiitJQo4sby30+uzQyT
	 73JjmND2lXiON3TAxJ21KRZPSaNUIeZ9Peoh/0cMqqC0++q2kbMm33LX0kEptb66x6HuE
	 m2RBG3uSbubJqBvR3ZaBcSJCcOZ+TlFZLnJGDFgcgYx67gROixLPN/rp0WPX0Weem9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="zvFTt/Dg";
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D2606A336
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 22:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 593D2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=zvFTt/Dg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794177179; x=1794436379;
	bh=YMj96xyXamRlNHvJIKz7F8bG9fRJ2XR/rAxoOAsux64=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=zvFTt/DgL0JKAuCW3DjlnYZGnDr7m19yuHr4HAzWvoVK2B+vIMatCtAYzK8kVjB0d
	 ODV1QWk8E/g3UK8EOM4YWCPSEyZ6LbXK3yzm62BgAW+ktxYo0A3avar1Y5Hqe74AnG
	 8e4T329aBtMaactWCsTlavmP9oR6sVnuGwtSVXF8lPwgsPbXAzmtiW81BOdfb7y4ZC
	 5F9u7werg0YutwJMNKcJtz7kHrfDk+aeWdFe/xRXgeZk43SXS46eESfn/NaDKIj5Sw
	 BSEj8bkjRzliJEsJyDYcB+CG8OBmGEAAQA0WFeyQV7iGFV4FIjTJc8EOTuNdF4uJFh
	 VqHz+y64reDrA==
Date: Sun, 08 Nov 2026 22:32:55 +0000
To: "slava@dubeyko.com" <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] hfsplus: enforce legacy sequence fixup table invariant
Message-ID: <XizPhPDPPpkNfPh9_zn3vMVegijzle2lWWBSUgdPB3tpi8xMB2qBIDun8c_X7eyFVMgq0zBlmGikFuBstwkN-O0l2bfQcmA5gtxudDOHUQg=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 870331d8d3b4d5d6feda88c12d0079b4584fa434
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

hfsplus_fixup_legacy_sequences() can grow *len and memmove the tail
upward with no check that the replacement fits the caller's buffer -
safety rests entirely on every table entry satisfying repl_len <=3D
match_len. The table is regenerated from Unicode data, and the sibling
decomposer asserts its invariants at build time, so this one deserves a
guard too. With the current table the invariant holds (no entry grows a
sequence), so this is purely regression protection:

    if (WARN_ON_ONCE(f->repl_len > f->match_len))
            continue;

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), fs/hfsplus/tables.c:3701-3742, callers fs/hfsplus/u=
nicode.c:551,670.
New table/code added in this window.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/fs/hfsplus/tables.c b/fs/hfsplus/tables.c
index 2101201..0b2aabd 100644
--- a/fs/hfsplus/tables.c
+++ b/fs/hfsplus/tables.c
@@ -3709,6 +3709,13 @@ void hfsplus_fixup_legacy_sequences(u16 *buf, int *l=
en)
 =09=09for (j =3D 0; j < ARRAY_SIZE(hfsplus_legacy_seq_fixups); j++) {
 =09=09=09struct hfsplus_legacy_seq_fixup *f =3D
 =09=09=09=09=09=09&hfsplus_legacy_seq_fixups[j];
+
+=09=09=09=09=09=09/* A replacement must never be longer than the sequence =
it
+=09=09=09=09=09=09 * replaces: the caller's buffer is sized to the origina=
l
+=09=09=09=09=09=09 * length and *len may not grow.
+=09=09=09=09=09=09 */
+=09=09=09=09=09=09if (WARN_ON_ONCE(f->repl_len > f->match_len))
+=09=09=09=09=09=09=09continue;
 =09=09=09u16 *src, *dst;
 =09=09=09size_t copy_len;
 =09=09=09int k;

