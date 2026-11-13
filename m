Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608041;
	b=DNE6rp/RbvqTXpxUVhmKztpYjG3P4vy5NN/LF2xKIu35JZuNVLMbNBsXpEq7d9LZRKLc
	 IuL6/ObAl1a4yMzB7Yl264eZQvxmbUxJJzohgW5DEWHJzrrHC+dwT6ty4pSL66uO5CxCN
	 XeheC0JcLTJIIj5nhTuvc2VY2baCS/B9OcaJ7s1GgRSwCLVBFDbUKI5HVNqEgEKmoLWO8
	 EABlR3ElbmjdXzQX6CTh56Dvb5C/s6fzUEbHo0fyHKjamC4KaSzRu+3K6JZdz2/WNYixJ
	 rP8G4A5qlzgrg/jsQOrR7/y6O0grYdxwsMIaMjc7PPIoRBjcxSYnyTztQZ09vHKNAaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EfW5r72ztIVpTPsFjdHYnm3oK6ZY2qO8ZM5ubM8gZAk=;
	b=mWniZ13g56JV8wjUXLgpTwJfL5/xyqi3y04lCeoixtqxObwq3eJtQsDJ06bUO0yS6IIA
	 LLnVCCINux3ovGELVWZdyxljel631u1K3mamZ7QHERDkxLUWBokmhKcE857lFZS6lWM0U
	 axvOT5vvZ+xvuygHGLzQXV++r9wuMf11WoKIgjUJG+PkpdH8P8JFW5G2SH5+f4VuGNfIU
	 ZNF8P2AxRPGaGI7ZyHglg1XNd+DhVtsyZT90zGu6xdalED/auH+6tMvqS5bjZVBXMu9n1
	 +FeSMCPq9VpEY/qYEo0qjrPUQ9aaii5V0Urxy2IDPM6hN3ahnXmwiBB0MDv7YSlmovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gp3+oZfi;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FD606A336
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 106FD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gp3+oZfi
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b25d977b91so1234611c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608040; x=1795212840; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfW5r72ztIVpTPsFjdHYnm3oK6ZY2qO8ZM5ubM8gZAk=;
        b=Gp3+oZfipAwpCv6RQBf3lDsHT0qEp1qD0xIU57NwQdPHacBufI3y/HY7/OzAFWbLjK
         COC86LQPt+kgTBoKHOH3z6liqUMbnRcvtWkBB8WIqiXDeiT4yGTVjFMACF1ENKsDRbjx
         C3I0ki9/tkmtjMMKA7wp0aKqDyg0qSYa2CbrM2wVKFsFljYWzj+9s9c16NYqeljycZwO
         iVGH7QDXUWto3Mg/o5+eK2TJvkhs9meOk57rJhHmcN6kCEqi48DpXJcEWMzNJ5yGHuUx
         jDmPg41tRHpFxTCOlMTfPNin1c89BrbkTIVqWmod8KAvcs1ZMcaLvN+715sxpWXF+n3Q
         1aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608040; x=1795212840;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfW5r72ztIVpTPsFjdHYnm3oK6ZY2qO8ZM5ubM8gZAk=;
        b=ykamI9vqqhQjVKchm0E3UaBnLcuGjwnh1k2bqFHecnHvMboryH4DstZ15kBaxtNkxu
         XZbyxP/QyR7OycGsv1papZSk8oQ8P5SGbhf8ZH/9+GLdYc0pZthx3Mg1VmzHncPTM0zz
         UqZBqZVLIPPS8jPRQYPC8Epn5Hpd9TkXR3xryeLQH1TvFN96TOPRr4XEnQR0Yv+/Qa1c
         d2rAYuQ3KbwvSd5D29X+PZbp6sL21pEdEy4m4ktzPbCxrXse6pX3ZBE3g2n/xWN2B9/1
         eWJC6ibj7rzzMO1Nwp+o3SidUAIBOviKgMhil1erPhB0Evi+ZCOk88F0Dp6KI8eS2k0S
         ecXw==
X-Forwarded-Encrypted: i=1; AL+hErFdkcvEnnawnSyWjVBgKNQPQGhNxEvc8+UqlrLar2BOSrpamjczzy8NwGNBMpImnuu86mx36VkwWguvpdXx@vger.kernel.org
X-Gm-Message-State: APuU4Z8tiDUZ1D05WGIY8EaGO4UJTgMBOLStEqQlFBuvSGvstDxPGASY
	oW+pAQQoB4spjiigXS3gaXVWckPpqyO/sRVMeW2ZoNJrOirZ4gGXyrYMgwdt449FzoxtsGAoTUG
	9JcxCgR0PPtGITg==
X-Received: from dltt2.prod.google.com ([2002:a05:701a:c962:b0:1b2:3bcd:9068])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b88c:b0:1b5:58e:b547 with SMTP id a92af1059eb24-1b5058eb73fmr2722892c88.22.1794608039776;
 Fri, 13 Nov 2026 14:13:59 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:46 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-12-wusamuel@google.com>
Subject: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

PAGEMAP_SCAN (0x10) and PROCMAP_QUERY (0x11) use PROCFS_IOCTL_MAGIC.
ext4 uses the same numbers on other files, so mark the row as a
conflict.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index dbe462040999..fbc3537fc9ee 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -248,6 +248,7 @@ Code  Seq#    Include File                                             Comments
 'f'   00-0F  fs/ext4/ext4.h                                            conflict!
 'f'   00-0F  linux/fs.h                                                conflict!
 'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       conflict!
+'f'   10-11  linux/fs.h                                                conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
 'f'   13-27  linux/fscrypt.h
 'f'   81-8F  linux/fsverity.h
 'g'   00-0F  linux/usb/gadgetfs.h
-- 
2.56.0.679.gc527c65306-goog

