Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763985;
	b=m3QRTH4honJNSd2CjXWPDPNeQQeqwcQLZTozMlab0QTlsBp3MYWUvqrDqMV8jfyFW4XT
	 MHVvi2exND74LQWv82fspiu5hxUrDr7Z3sTuVA2yKBY5o1kOz5yUnwIH1d7zZsvsXY2sW
	 p7AoSmsgrwz3pZxVRi+RKdyoWRIGOYU2KFbnfBd8I8rIfiWoyb+Ii5B64K8stEkUP6l3Y
	 5cp/gHNaUvc8Mh273oybF8FKzoc51dTZYJpe3Ivwme3tM43Cow3SDDCud/SRdC0zy22XX
	 mVebH8DF7nFTXHjPOUeXPu1yWmUlRAuX/VlKdlaguR6UEc1WlYQLj4ddQT3N9/pMAEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vxJLmV6OXCoxa83sUUnlyhlj59SW1UTBuaKREwaI5xs=;
	b=SXQ6sSG7vu1+ij+o/+DG45LojP9AB+RFk18cRXHixZ+7bNgrcmGM7Vld0MTSuRpcB28G
	 moua3qqP3u3QzUO5yvzXYDGHrukKg6lJWypdCDYLzTgS8kvkbu2DA+12U/f/q0SfCxqEe
	 e0OqhXcJ30Mn4EH6pE/PEJdsLErxQmwXHfL7pxhPMgx+YXtVoFOVebq96V7Twjc16kbTw
	 lg/lCHxld68191CRr+yr8yBL8QylOfpPk6MbK51JIaN6mKiKek2U61fDXlGbC/A8CLk/l
	 HB9+I+l2K0KUVVGjsll1MpMo7861KuN/2wHxVELBVBhbXEW2ERL3BFVci4Orlv4zWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eCwPBjAb;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE6606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 03:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EAE6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eCwPBjAb
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b312be5de8so1609567b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 19:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793763979; x=1794368779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxJLmV6OXCoxa83sUUnlyhlj59SW1UTBuaKREwaI5xs=;
        b=eCwPBjAb3NxMDUZxnVXXHzzGe4OTamvDv7DRDfxO0hxmggqPvc7mx1hkEjLlr6Q78s
         0BEGtP1o8tbCe8p69PZg47w1P9iYgQXt8vzkc+SZAHzqIaK3ut8DwDAvulLH2FMbsH+V
         Icf0ezrtQMZjUQys1GhKiCWG4/szbEM6jhepnfyuymF23Qb8HyerfvuwbDPo+s3PDcnw
         kg7iAXWgMQsXNbCGF5mJFg3vVlXx0UBPcbcQjG4Ue4gQg2e0gf6qQmG6sKUwwn3UAyPY
         vAolazpUjoi0rxlsyAf9WXnJ4N8PcI0VpmQGBVi3K3jm2cvrfYsOhoA8pbuXH5or3Z9z
         n1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763979; x=1794368779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxJLmV6OXCoxa83sUUnlyhlj59SW1UTBuaKREwaI5xs=;
        b=oc0EK/vgcixOnZmY6k8UxzNpTpi+0qcWWbsxVkbBYx+3vRXgoGarUKwmC+2G1TgMPl
         x8Ae2nfClVNFP2/H/K38jT1oxksPRU6Jna+XPhzYZvdfw3AXrNj/rFTmzLt+j4I2AkgX
         i1UGv1obURxQsSUUiBttBPCVXfGM20NS87FY0kv9j8N4XN99DdTS45Hcjzl8NzDg1pIi
         Ul9QA8LF1QPlGG51zehnZFvJbsI7k8O1KvQUjYaO+FL79lu/HRmDXjKkqTQ6n3dJgz8X
         iCMbo5Wp6pEon4io4jE9uiLDodob0xfZjjdtOgBcguUn1f31mAYLfv8Og0H3Ozgu0s5+
         ccnQ==
X-Gm-Message-State: APuU4Z9jVRvj35n6yAWicyizCbmwPllhhmKKeIf+gG3C7PJNtFpEj76x
	Urbe3cj22Awze/7e1ul65Nehj7S0ekxxZnqyjyVGnLzmI4negPEdHKIyIxsXcOy+Ub+RY4FjHZy
	qQtUeE9c=
X-Gm-Gg: AYBFou37ueV8qhe3w+9AJOnadNAM1suHNjq5K/9Hzfx+pZWyDJFTswR1w4KYYnSV5jO
	cGP+fyhmeAxAoMSaReukHAkxaTotRr9OBX7uIYLhTZIZ4gBCp6qpCDkI0pfJCHhf9u6bR78lwqr
	EFxcwaxgFXsf3jQ2e19YtY2nk/WmH9LdxFx424L1WiOjwSN1fXHiBtCKFzGLn5cFGzJIqR3FpE3
	j7iRlAjvdaYSMNQv7X3BEqLvgl6wsERrzRqjOGBLkm1JHU0rs9eOVVbcmEIr7+c28RdWOt9v7Z6
	91ItEELTFJ9+7uXR2KSx+56Oo0/5ArKQoBKOR7He9Of8xJnGp7q/aKkhA0oWxv3KoUtOPuNsmut
	WA15Q1CFqTuJ9187J50IIiGfa5ZiONezOiYKwWtuxIYqbkztO0xkpCu/utqM+1wO25ADvrLaNfA
	ZdeTWtFbXAYdfS6ROCGxTXwOUMASXO5KKidoKqOom/nzaIGNcE97zIvSLy61W5TrZ9s7s+it6mi
	aEV61o1cTCcNQif3X5EY7JhsTHifPdCQUDvxfFa8dEovOle7olbX+nL6iW2QXyPzWUqu8dShR2x
	ZDeE6UXOVFxZr0+7cYwd+J9Fu7JNBvPMkHAkHvInfIffdNeAiLPNdrHJS0jd5ab7iI105p35fgg
	QI7HeICnvRg1Cu1VZA88oR9QlhkEr760NMgBnnrqbYTk1Ewj1V6Qm44tf7A5H0vAFy0I8A5weRa
	Z9h6NC
X-Received: by 2002:a05:690c:e3eb:b0:8ae:9448:14c2 with SMTP id 00721157ae682-8b2b67dad22mr93460477b3.99.1793763978973;
        Tue, 03 Nov 2026 19:46:18 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1921:d22d:3124:a258])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309711412sm10918117b3.3.2026.11.03.19.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:46:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/2] hfsplus: make hidden directory name independent from nls
Date: Tue,  3 Nov 2026 19:46:03 -0800
Message-ID: <20261104034605.1582293-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
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

HFS+ keeps the indirect node files of hard links in the hidden
directory of the root folder. On disk, its name is four U+0000 (NUL)
characters followed by "HFS+ Private Data". Currently, the catalog key
of this directory is built from the UTF-8 string HFSP_HIDDENDIR_NAME
by means of the nls table of the mount. hfsplus_fill_super() works
around it by temporarily replacing sbi->nls with utf8 table, but
hfsplus_reconfigure() creates the hidden directory on remount
read-write with the mount's nls table. As a result, with nls=cp437,
for example, the hidden directory is created with garbled name that
neither macOS nor the next mount recognizes.

At first, define the on-disk name of the hidden directory as
constant UTF-16 string hfsplus_hidden_dir_name_utf16, introduces
hfsplus_create_cat_uni() that creates catalog records for already
converted name, and removes the temporary nls replacement from
hfsplus_fill_super(). The length of the name is calculated from named
constants, and the UTF-8 and UTF-16 representations of the name are
distinguished by the HFSP_HIDDENDIR_NAME_UTF8* and
HFSP_HIDDENDIR_NAME_UTF16_LEN macros.

Secondly, add KUnit test that checks that hfsplus_asc2uni()
converts HFSP_HIDDENDIR_NAME_UTF8 with utf8 nls table into exactly
hfsplus_hidden_dir_name_utf16, with decomposition enabled and
disabled.

The hfsplus_unicode KUnit suite passes (35 tests) under UML.

Viacheslav Dubeyko (2):
  hfsplus: make hidden directory name independent from mount's nls
  hfsplus: add KUnit check for hidden directory name

 fs/hfsplus/catalog.c       | 83 ++++++++++++++++++++++++++++++--------
 fs/hfsplus/hfsplus_fs.h    |  6 +++
 fs/hfsplus/super.c         | 68 +++++++++++++++++--------------
 fs/hfsplus/unicode_test.c  | 55 +++++++++++++++++++++++++
 include/linux/hfs_common.h | 20 ++++++++-
 5 files changed, 182 insertions(+), 50 deletions(-)


base-commit: 71d5a8a05c83b61bce1884905c192eed34ed3069
-- 
2.43.0

