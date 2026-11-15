Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777020;
	b=Dj88LuRA2oKIh87tzej59wNngygu8g8/bgZTI5KA6kuwkiS+a8noCBhKodRobMTG8GHn
	 6ZKKYIP09O0eiTk3ePHuAm8kLWi9V2C8yhF3psqceRfXEykikn1ddJ+wFrK3MFfaqqt/5
	 6Cbx+LqgGXHhkQdGS+A0ZGgOcsFzEBx1AeWaZJmF6Prrjl8HKYQlU4FFBJmjhKWjRJYaW
	 ERy89V9bDFav8KN/Zum1OQ8UK9ExR3Q2sYkaBDgqCaNL+k/qgOLy/pLodTNEtb7nk/nRT
	 Evsbt5Zh1RAu1ErfPRdJ72Dirad1FKQhMFtCC1vyyH9oCgMygrTWS/Xz2Zh7kydXlyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/ARd3XR21b98dC+E0q+y0HBDJ/Q/aPk0xOOUSlTPKys=;
	b=mc1odIcWqJ/qcRuN1TWOuP7L3Peq+SvmJ+sJZDAo6GLQ74MihjAufzDwgLjkZkrJlgX8
	 nCK2PlB/koUsoyZeB73mN49EShqZfkZJPjyLXeEeIuo2sjJJy3MO3OacMn/Tqa6RQG3Z/
	 FyjMzVmyKyLJp987nnphAGSbX9AuEAYVr9Qe+xV/rx3QOAQuOdMWNd0ymYoZ6uP6QzwIW
	 tbLXRhS9iHunQ+V5gjVoYpRFPGJtPVC4xL8tWeiXPqCZcvJlLkbPs2B772VVNRBLiRe9V
	 GcCk9H6NiCPCXIgOYNOspkZWhigWqaHI8HsATltE5i7MjDpJoRxcdxwGpZvVvKpKBkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zov0bB1B;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB84606A335
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 21:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB84606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zov0bB1B
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1249591b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777019; x=1795381819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ARd3XR21b98dC+E0q+y0HBDJ/Q/aPk0xOOUSlTPKys=;
        b=zov0bB1BeWYlvinho67CCGeV5prFtKbwWE5DLx9OjQ9i5m0s4tKX7fcbk9OnyZxscj
         iiIZn1Pe0QEadl9n0hXFATr+CIi22CgXmZ+ZvhSGE/YNbvnwoYW3b+jMhU13p3BSIjrq
         Iws/Wvp0ObtM3pHjNj/727/xUe2atB+gxKGMqJsexyGvTKRsfsQ8WfCAAmrbLe7lpXJj
         OuF1IhLuRSTcEf9foqQkIJ9H59SqT/4n8tm/GfxFgyj2JKwbvMnwCrhqWZcx1uhj9eRV
         CuCxJaL5IzARj3qrtmPtHCb8HoBRC4gsCO6tTCGHZ3alIWAb9uFhQ/SnTJ+dOYlmYvOe
         oS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777019; x=1795381819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ARd3XR21b98dC+E0q+y0HBDJ/Q/aPk0xOOUSlTPKys=;
        b=ZVLx/jhajEfFx2N9lENl26/9k+xowaDriKMlU41ZVBQp2oRSaS2Wxq9mjCk12KDC5y
         dYpW4lQjVAVOatxZwjusSfElE/QJUd/+i/TFYJ0yJLkFh9M8X0hGYJx7XRlj9kFnaXSX
         MsAq77hb1s0KGccsy0hkUGNDZlfg8Lqdq6ARUDKVNRSu9yRN/VZLy5q2LGXgVhhSm7dO
         25bDuF/0dR9GFLpIyzOZIeWlOHGRaWoNkWBoYTrjEPBQQnZ3v/Dlr2ZZgCOT9dyDx5pj
         7xfTCIdYmA7kUWNxN3gTCnvskg9pyD7SXBQjnWRccc/7+YnGIX4VatbbDlXicVgLj/E+
         Vypg==
X-Forwarded-Encrypted: i=1; AL+hErGg4RWqw4ceI/27NAHUOC3EXewblVOaJ69d+P1Z7pMiWE8LoHsNIqA44T9u300nQwC/d8/lp0meUzbl/cIV@vger.kernel.org
X-Gm-Message-State: APuU4Z9NTAPYfa2xXkEHuLpl7ysFjA/Q9Zm7iYDnjtB/+iwIFkVIvFJE
	YfAxTMuvEHPk+lwddECD1/O0WM6l37dlXCvaUnVUgeGhBCr3vdPb5wvt
X-Gm-Gg: AYBFou077W6ru/Ne5GTbIv2clIYwAkhuG1A802RywY+NDG6cRNMlp3j+FWdz/y4XW4X
	g+LJeFd83XZLVaYXTxjQng5SBib8kQt4L8X4VLmqwOGeuGnUUp9vK97elPOtpqeutsERm+UHcaR
	Ee88I3yYQuyWsxNrRXgHQjPVObuec3064Ba8qEGLtgu/BJNkomeIANSM8oKWopN7QuW1Xey43ls
	d3BVz48A0YmJuhcdN1I24h3jl80hpcfKKtsS72MxWYCC+OIPTVsRgdzG7V2sl6xlEh1pPzKp0rz
	BGRSNKlbVjHIrvXQOYDPBj/2iuo+UwRQ2UOiYRSoyYINAUlX4qCDqwFtv/foGxHNVl0xm0/s+zE
	ANsQQrbaFQK0mJy82mP03AdCL/R7bItl+rss9Y9Y21yeuWFyBluaq2a6jPY0EOk8lryovEvae0A
	Ut5ayMrmYPizvIOabe1fVIaKzzeGtwX2nQMlBRS+z8L/TN0q33hh1IMjXBXV5jQATAK1FqkCejm
	Vdy8E6JZhjuUC4I43KDbKSfbnpuJwDkMJ9VxrjPfXKzx1EoElsOsAFrnRxagQyHq0gES38GAQCQ
	wRMT0/y/fQ35Qfu0cusZcMzhBY122s9yQKYl3Pk4N1T3AXaYzQ==
X-Received: by 2002:a05:6a00:1a89:b0:8b1:e8cd:49cf with SMTP id d2e1a72fcca58-8beb619b3f3mr7131715b3a.22.1794777019150;
        Sun, 15 Nov 2026 13:10:19 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:17 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] fanotify: zero-pad copied event names after an embedded NUL
Date: Mon, 16 Nov 2026 06:09:50 +0900
Message-ID: <20261115210952.2140036-4-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fanotify_alloc_name_event() sizes the variable-length event buffer from
the qstr lengths and allocates it via kvmalloc() without zeroing.
fanotify_info_copy_name() and fanotify_info_copy_name2() record
name->len in info->name_len and info->name2_len, but copy the strings
with strscpy().

If a qstr contains an embedded NUL byte, strscpy() stops at the first
NUL and leaves the trailing bytes of the allocated name buffer
uninitialized. copy_fid_info_to_user() then copies name_len + 1 bytes
to userspace, leaking uninitialized kernel heap memory.

This mismatch dates back to
commit 929943b38daf ("fanotify: add support for FAN_REPORT_NAME") and
remained after commit 0fdbe845534f
("fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}").

Switch both helpers to strscpy_pad() so any trailing bytes up to the
recorded length are zeroed.

Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Note: default FUSE mounts report a zero fsid (-ENODEV on fanotify_mark()
with FAN_REPORT_DFID_NAME), so this patch was runtime-tested on tmpfs
with FAN_REPORT_DFID_NAME create and FAN_RENAME events.

 fs/notify/fanotify/fanotify.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c25cf5c1fc70..4a1f14aa4974 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -225,14 +225,14 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 		return;
 
 	info->name_len = name->len;
-	strscpy(fanotify_info_name(info), name->name, name->len + 1);
+	strscpy_pad(fanotify_info_name(info), name->name, name->len + 1);
 }
 
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 					    const struct qstr *name)
 {
 	info->name2_len = name->len;
-	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
+	strscpy_pad(fanotify_info_name2(info), name->name, name->len + 1);
 }
 
 /*
-- 
2.43.0
