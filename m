Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359926;
	b=nAzD82bhUPEpiZZjcVEpeUEnTUZ/rr9rYeXxrbk3VnDDUsLKAT83tsA8yVaQq5jIqOIm
	 VlN6o0AZBr1ypJhkuKTWekWtAUh4iORBeq43Mx8F4//Ow1F6xm3yaf+80wqS74AFndNfZ
	 5ntWBe5ZuUx4Mr/0zKmBQGBbjNfi8cYP5/h9Wziucz5brReZ5h7/5n2l8YrzrHxuo5XZe
	 EI6IjwpjBzYnWgNlU7ZYnpiCpI3s3Q8GQsg06H8eD0jn5YYWCgNMILYyzbc7g+0KWKl8L
	 cvzFdWxhgAZ2evvXT1yjXdcKioNgLXnhBshhiTEfUqIgaJOFz9cu/MFGmrsWC4EwHgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bBabPJq3TODdbBocrBAZgPnc+pz3vo4Y94D8Fs7pGQQ=;
	b=UxZyTdUOwdDnOezoA+IYVuXRhZtFrFMI1//5o4zU0M+TuJNhLJzPdl7AKf0fVsj1W+4W
	 ByZE0/eUgpu3fZgepHqx+RAl6TmfGZii3TKS+3nPzKxzeTpqTa5UprujZUZIPIXQXnP4K
	 kmf1xpyRvGOPUdGrJh+1lstK/vleWKHLpBnDQx2qS+rrqP14mwSGe/GGAxgRDsjxnvrg8
	 7Vas3rCa8R2QeT9vQYobOgdc1KX7lAHwk1HmyMVg8/X1GRITGr8prRZdGygdlQGW+aypN
	 94yMqwhknQhV7327yBZA0MmdqYM5nR0yTEuCJfrsHwsjYkB0oyD1iBOgwAhP06TPxEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eht8YF29;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA758606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 11:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA758606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eht8YF29
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48afbd2c386so312831f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359924; x=1793964724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBabPJq3TODdbBocrBAZgPnc+pz3vo4Y94D8Fs7pGQQ=;
        b=eht8YF29ZDQ5aiSn7neLwPfe0QqbQ0IqFaz23xAlDMXrUOyhRt9SvfmfqLNxG9Vpwt
         1zK3pFVc+m4nU2R+VCXrQADdxrCUrnDZP8l0rK25ojasT1GgGFTZOahBpfHpOO4PZCtK
         8XU+96icNPU3rNKu3qE4x0eyg1twT7Btt3KvfL/DXFw72CtNVlVIzVJ476SQzMLR7+Z0
         C4I42jTsHVtElvx1tb8onWwX/1ZNMGLRfjxnbi61JH4+vy50kpyB7AAuf9Cjtx/ZChB5
         GWr6w20p4jpKexs/2Ke1wnFRlSZLPZUbaXVwZ2TuyJy17mOKZMhRo6pAcXKUjMhow1z4
         IYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359924; x=1793964724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBabPJq3TODdbBocrBAZgPnc+pz3vo4Y94D8Fs7pGQQ=;
        b=H0aqkqWNMUeNprdFEqUCBEyOV8nypWm8QQp2ulpV+BISi1GxCCPqyUgO4zJ7oEdl2t
         /TPQGycWQi4z2AYiyrtL8yRKhG4jP2QYONz/oZtHuA/Vxu8Z6Lf/Z5tl0571gPipKeoB
         hEqlNM3i0ZlGUfaz9ZznrGybmL4mcbQy7l2isWcwFpjWD/lmMPFhh0IQpArdazQANruZ
         Lxf30tHXPYmHA5q7nm9yss0yLTA3BUjL6pEsRCVmPRJvTnJ/VeQGW6lmF7Ig+FR8yd8n
         vLIwsNRU7kghLgo+wNZxnAjGH0oYgiSlpZi2/N6ALQYjgya36TmVmJQqeH/81zbbl3zi
         r/Wg==
X-Forwarded-Encrypted: i=1; AKwUvByzR6etjmH5XLTM5nPSHsIod7hIie1YkluioALYY1r7tIHBL26nw4eYQkG67lNUs6iH84r4XFHWbOKSNokH@vger.kernel.org
X-Gm-Message-State: AFq9FYIxpC1T7q9+RYR5rPuBB+dskTJP5JGGmppHLPAvB6HIJazfevKY
	zz/KreOOVyTsWjxH30NDKdaQreDUORZ4IFpmtzswV9jpAFH/R/by9qHoiCGONA/v
X-Gm-Gg: AYBFou1RkhCRGA33W/f50/n81t3/y3STBnIMyAQ8Gwb45BNJsFAI/yC2k2xnqspAmPv
	erHZmWqTRTUjObVBeS9UAFFY84x0T4hGK524T4P5kPC1s9td/cH+V6L6FrtqE1liJKMMMBtkp7A
	sDpqksRejZ1eGOGELch1jYRxOC0QIwwaSoiaa6VWsRe0+zKKvmPmn8NjcMxYz7Pc+2Tpn6pxBpr
	8QR5d3+EMvGYEvbkCUtAIGHJNmrgieLeiZsOtSRpaXg9rnbyRFzeJfcSntDR+aX6/kRPqyjxKmh
	Eigc46FpP1kWDm55uwueRJowWN1cMSsTZj/hme3vrX4ScFtiJWPZDFP/tJdgFMEU0Z1WHn7jmzW
	vfINuRDtZQW674stREW4BqluaRaGTPw1z+CqY2619R0qEBIERxi+Rd1DpZO8zRvX7wUsHhi1/Lw
	vpHwbxBGqQ1bmZ6hiyf+dflyMjHqhaNBj4o4V2zxPsyYA8yy+XKlzJZk/EBmWLLqJxJQHpLeRKn
	uGUnMm4f+cBqcGFmu0uwyhQgyGq2maLpAPo8L7yGR3YRTgGzr1yVNSzgiust0PXGIUmGSIhHP6B
	u9hO/IPp9BQEtZdCKFTmxigzMvSEjW5fd4Wt2NWOCGPFv8mVmVkvBa/rBc9JL3oU6kR5gQ+79AH
	Hibx5+Uee4QVF
X-Received: by 2002:a05:6000:26c8:b0:48b:677:f80d with SMTP id ffacd0b85a97d-48e6e2ff7demr4687700f8f.26.1793359923805;
        Fri, 30 Oct 2026 04:32:03 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba5dc2sm2647955f8f.54.2026.10.30.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Overlayfs casefold fixes
Date: Fri, 30 Oct 2026 12:31:58 +0100
Message-ID: <20261030113201.2921633-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Hungyu,

You indicated that you are willing to review and test overlayfs casefold
fixes.

Here are a bunch of fixes that I recived from Chris and added my edits.

They pass the basic sanity tests, but I fear that given the nature of
those reports, the test coverage for casefold overlayfs is not so good
and possibly there are no many users, so I am reluctant to merged the
changes without a champion to verify them.

I am not really interested in adding test coverage for underlying change
races, but the functional bugs that are not related to delicate timing
deserve test coverage.

Please see fstest generic/783 and see if a similar test could be
added to add test coverage.

Note that it is intentionally not an overlay/ fstest, but a generic
test which only runs on filesystems that support casefold (e.g. ext4)
and the test itself takes care of mounting overlayfs.

Thanks,
Amir.

Chris Mason (3):
  ovl: fail the mount if the casefold flag has changed
  ovl: do not let chattr change the casefold flag
  ovl: fix whiteout creation in casefolded directories

 fs/overlayfs/dir.c       | 46 ++++++++++++++++++++++------------------
 fs/overlayfs/inode.c     |  8 +++++++
 fs/overlayfs/overlayfs.h | 10 +--------
 fs/overlayfs/readdir.c   |  3 ++-
 fs/overlayfs/super.c     | 12 ++++++++++-
 fs/overlayfs/util.c      |  2 +-
 6 files changed, 48 insertions(+), 33 deletions(-)

-- 
2.55.0

