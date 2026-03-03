Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3435DA71
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577484; cv=none; b=NM5sUre+3C2i96rlB+dzya7sggu99MavAu0/LfyZB7q+ywrVzzGp+n/hed7gF9f6+bN8Kay9CK4NdhYTWzrUkKg0nNgBb1RDf1xW94lefTJF0G49mkRE6NkjhXTJRta937Ipbd8Ox2SaHDuJ+qXxYDuZRe4xuNPgbs8U8El1+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577484; c=relaxed/simple;
	bh=+C9UCavQkoVwL+J+IJg1ofBcDjCKdUUSuXXXw7b0xHU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bGX7Ru146AmCok0q0nDgs9pdK2cq4mxR+shIXYC7RwvW+bgVpztg87AFGO6mEGOQO6gQTh03O7SBoca5aY+YCDEn2CjkUX4gVCcjmHntR8mKFsAqkUTxVgxA0LxYE4kjTRCffEdO3tJlHNW4I1e/chtzcdcZXNx6Ck5tAyoVTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d49709f87aso70789705a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 14:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577482; x=1773182282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R7pc2WNAM1CjF+jiPOWSxHuDNZHMZhjC9JnQBKJnbw=;
        b=R8YrXCLl5MKTZA5DybGmgrmg1K0bLIfqYSMm0QTg4A+0DV12+LTNIjlMu0bGiZq4pm
         sHOvggtPW14/ZC7PNCPwGohn3FI3nHdlJ+w5op2i3lfL3hXhEMGu1DPtZvwkPmmXMfLQ
         mFo/vZy0+QYmKlx0gT2MShz8ixmZSWgg1cfLW1meBsUUsx+ilSJg2SCJ6h4SiswSangn
         ypojuqn3ZRZoJxwgp8fUXonK81l4wBh/N/JAQZp0sjctglWLwHc239LE/6kJjq4XO+d/
         Gbm5hNL9ichykI88Aa0j9lH2qELhpq2j3AhhfPn0W5cHfzc/L4oDtv0H9VAq7BDqrud8
         GF3w==
X-Forwarded-Encrypted: i=1; AJvYcCVuvjtz0m96b83/4lECf9kpp5GRn+/DFvJeHdObyMtIXoYb9feG3QEc4ae6qoFFUtJvvGlIh9LCJM9MWJ9l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33c/fVf8jgzUx2Y6gjd6q9ZGHkrw4wL3L+R0ny/PVXvVCvPKX
	D2IW2g+nW01DTU0mgvwf97uWx3chDBM49ib5KHMdxEgu/6f9S6ntj9ssxDTnR23X0JobMhTPJTe
	Xry6QHMr4w16EfoVAehoT761cAneiPecldBkWoVOd6F44zyx+9TS5+12wIV0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6acf:b0:676:aeb2:640 with SMTP id
 006d021491bc7-67b0ffa767amr92169eaf.4.1772577482416; Tue, 03 Mar 2026
 14:38:02 -0800 (PST)
Date: Tue, 03 Mar 2026 14:38:02 -0800
In-Reply-To: <CAJnrk1YQMZBHE+EhhDbxM9nAzCeBDkpr-w4128fSXVPNj03aPg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a762ca.a70a0220.b118c.0015.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: use-after-free Write in fuse_copy_do
From: syzbot <syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/fuse/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c025f6cf Add linux-next specific files for 20260303
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b410fabe2a4318
dashboard link: https://syzkaller.appspot.com/bug?extid=23299dfcac137a96834a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1620f0ba580000

