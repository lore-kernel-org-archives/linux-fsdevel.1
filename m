Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435466;
	b=GsZz0xptkGDcIHxC77SBtCDRX69GuyA8/hesFRrCV4+cE0l9CyPNzT7/YHpSz8FvlCq3
	 rUlMXNGYInnqhHZrh4UidoKngHVADcIld8wfyIlOgbxAMAF7+66qVO6pb+Uwe2Yh58nBY
	 G6Eh9rbSyqyTSozOzdJEoYdnZi9OdeIhuIIHS1Isd7jQVfYkNNVdxBk3XnK25ekK47qC/
	 gdiWfMj2Wb40yQZEVonE1THsb94wYs65KWdzMvgW7V25kIZM0ABuDINCWKMEP2YJOt+b3
	 WQplZIudnrx6teGJpS0rc7LDA5kgIB6D7sKpGS0wdEfka6g+muJd2laNglwUOypZxZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FwNbKMHP+2A+3oMs0iBFR8sdyk4GLtkJVZshv3zylWk=;
	b=sTKnIZV6TMkEb6tquMc2RK4QR+HEZzDkzodafSMbg88ouzoeMpzd35uMW4uVEehF8O/2
	 0U9XeqP+QXbfx99JJh1DIhp5oXE3z4B2rWqJzdWZteJxmISNmDDfIWjGNGbsvuF7olkph
	 5oWOmR3gLinFWV6iOA9H90x2GAXt5AoFZRNXMsDUSbYegTMUgqZl7h+zZz7UVyGcwQLYv
	 ytB/6XtBvDJbaQ40OpmYHq71Ir0NhqcURj/Bzk/fyfSu4jRkuphM4nuREbe6Hot81oxd6
	 ijnN5MGJVVwxQ9vu/zFVgIIN1maCQn/7eX3a9mTBI8phmj7xQaTMaH88ruad0pUTi+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WGrQWcHP;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434A606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 08:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B434A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WGrQWcHP
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e00eee27dso723811f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793435464; x=1794040264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FwNbKMHP+2A+3oMs0iBFR8sdyk4GLtkJVZshv3zylWk=;
        b=WGrQWcHPKjggA7hrcOG4ZeCmbvngzSZSWpCSeM2n/Xw1abuCru2ulRAuxZmiyoGwAw
         Kvmu0ofS4AhQpnW7UysgGXJKI6vLMIXMOvhCmUT4EfxfkJGJChjyimpjl/2n0neqLw2C
         F2q0dHrFp/ok6m94X3AOoWO/0mvLovv6jDqs0RWALAJwaj3Do7Pwp1CwLqdlGr3CJJGu
         apKgue/bQn8bc7kWF+8HPI3RAKxV/uEZ+SgTzHULq3XLyGom/+iLE/5kznrc9rgNmZxl
         PYRQsK9y7RlRVgWL8dgWMRuI2KAOiFEEPtc3A7HKKDiaKWu8GsJ3hNJjcpX1HyzL0MND
         MeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793435464; x=1794040264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwNbKMHP+2A+3oMs0iBFR8sdyk4GLtkJVZshv3zylWk=;
        b=Zj7nWc7HAQZ8UadTnX9xbT/6/D9dA4r9wsUnJOW+iVItjASb71RH+eRUgicprEzpZ6
         gYDZvnEruxOyJj6Xg0nvAg9dzzNTf9Xwz9Zeh7z3YRlDn5tFp+vp58h/QqbJa+opw/VI
         vEBJAzeHvvOQ1bLXIpoZb7/dV8MryGxpYzeaklOmgM9ZQKhaquH0Z5W9bVqHo8XcnP42
         iT/bA9U/1rKCScutQHEbFm7Qowm5+gvahLeDAblRLBHJdpKDtdCNikHtKm+VE+s1Eb/r
         Y5ImI3rDYvIRIGv1/zC+7jLQG//RMjcKHKJECVWjUDoisP5LUPECqOF6DS/xQIK8njMe
         n9RA==
X-Forwarded-Encrypted: i=1; AKwUvBwGUPWQVD+9TVvpSzl08TdkSSF/FG3NcABh3eFpomUDevmPAzPbs6FuGs4bzuq/a2xUSacyboVXO2498F+U@vger.kernel.org
X-Gm-Message-State: AFq9FYKCChYOSCGUmH3n9vKQIZsXgyr8BMW58aEomg/Z3zikU81nIb0K
	w3Zpbi9cLEcGRUtW5i+VXJzHjQl+LxQSaMh7TBPs17R9hrGkjA1aKKmDMBd3PLVG2Qo=
X-Gm-Gg: AYBFou2pm0cGnImldmsc9cupTuxZjOwnUUJ/3QiUA1/ONFOMdMgCVnde/PD7Bv2MrdC
	QsVVwu+GeGl9bSBxsc63t9/UmO0SyXiv//ipnP6sppHmYwQzJ7NrMGwDGYm7MI3j/QMtHMj1Fk0
	XpcjYHLJHna7zRuI9Kai868Czi02SZpW1xfUgatQeA/NMAmhMQkaokY2aVbCWznE+psp7Nw63fO
	F1mBkTZs3c75sWKY4+6mRk+UexyFrI6VY0mdNiYqAWkD1vxJVs1X/lesElA7Qzl/xO4R2evzO41
	P03BFVPW+X8SJq7eY+bA5IF+F/NYT7XGF183naaOFKuzqjFRGkitwqvf/Bp3E1/iqHQx2SfLKFy
	I8gQ82yhccm3q5ijkeH6nt24sTyW9AopRTG1ill9a2fKhT/42Q7mlV9hzyxVSZcYnPGzIiTOOQh
	cnUTuMYFIXZLyfZyPZkUV63X6tewLJVnf43v0h/X8O4ZOO9lVPDuwq2sk9MPM+iV7GpmXsNPemq
	L7QcUl0e064JfCKlpOz5HYZWRHx0lBp9p1stJjN7U9Bsm8Y3Ah4ESrmA1h3XoanFTqDiSajJbH6
	+IaMODCTCHlF2MnOkrxQGtUIYWUth1X2IPXfh7f1eXTcVAFtFuw4hOzXNjVhF05faA==
X-Received: by 2002:a05:6000:29cf:b0:48d:cda6:4dd7 with SMTP id ffacd0b85a97d-48e6e4ffa15mr7559556f8f.44.1793435463908;
        Sat, 31 Oct 2026 01:31:03 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c0b6sm7229726f8f.41.2026.10.31.01.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:31:03 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Breno Leitao <leitao@debian.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] fs/select: reject negative timeval components in do_compat_select()
Date: Sat, 31 Oct 2026 10:31:00 +0200
Message-ID: <20261031083059.3245047-2-thnkslprpt@gmail.com>
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

do_compat_select() normalizes old_timeval32 before validating the
timeout. Negative seconds and microseconds can cancel each other,
causing compat select() and old_select() to accept invalid timeouts.

Reject negative components before normalization (as kern_select()
already does) - and preserve the handling of oversized positive
tv_usec values.

A 32-bit syscall reproducer confirmed four incorrect results on the
unpatched kernel. With the fix applied, all my test cases passed on
both compat select interfaces.

Fixes: 4d36a9e65d49 ("select: deal with math overflow from borderline valid userland data")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 fs/select.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/select.c b/fs/select.c
index 95d76531015aa..8b6d1dd2977c6 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1265,6 +1265,8 @@ static int do_compat_select(int n, compat_ulong_t __user *inp,
 		if (copy_from_user(&tv, tvp, sizeof(tv)))
 			return -EFAULT;
 
+		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+			return -EINVAL;
 		to = &end_time;
 		if (poll_select_set_timeout(to,
 				tv.tv_sec + (tv.tv_usec / USEC_PER_SEC),

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0

