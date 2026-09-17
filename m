Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882043CE71
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628346; cv=none; b=atYKrhexCvTOChTce2ZyhygcaxRAANmWB5/1knSdF7HuombWWMMRtq92LSxaBMU6j7YCCORym0Lqw6+pSFe4BZ36Pa9ubALCND4b6FmR0Z6XaUzhYtHRgIx2LHNmDVucRjHJGxmbj3vE5FYs7Ja/tx+oKjZCvrrovpYQigPEIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628346; c=relaxed/simple;
	bh=ocm1oz3D6bzdO8b23gwQ0fUOwUowt/136rgo1dwg4wc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sfk/QcZnDmMRY6hXjAbh/Dc5Qu24veZ87Nk2JwULZNJWXlBClHmLQipi7nTBRLmW16mtXE0PHYQfEyrDpUByHfN4SoUOZVvgt28CAMBqK79P+ury+z95mCVookuFFOHnz87dmaZZTh/UDgyxn9n44SQsHW9XGmJcIEahVwSfUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4574f1cac98so957711fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 23:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628342; x=1790233142;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RA/zTH478ZP9Kc/vn5sqCuMNo+mxE1VsaPGXCtRcBhc=;
        b=P7TWeHnepH0lutEhRneGdkNjSRm2W5u2/whrruV4JBLxHBs1exRvFXoTMnc1lEQEAR
         P5k+hEpIrbQRz4UsKXMT2YnNi2++hzKVEf1hAw+C+I6VsrI6r7+8AbhPCS3w9dOFZBCi
         mEZ1OccHnPRVAYpqlc7G5dFoG28OaFVJEd93uBrDtgNYqizglC5X8PMrMdFfMqdDfT5R
         tVR7YqLPIJOeRen1yBOrrUdvOABPxHidoWe0lu/Aesk+EUnQhBpPF2kLlHmhIji6crtK
         iwW9w51ytcg9kspyzR9LV6cqoF4aDWGUXjXRc6du0vrSBOG0B/uHn1EjN072MkylHK04
         E1WA==
X-Forwarded-Encrypted: i=1; AKwUvBzoihB+hRRtzqH9oEsoxDgMfO6DDgYz41l+eajbtHd9L3WiMQlYldRVOpXTfKGtERr1UoQ/kQ1YNff/uZgf@vger.kernel.org
X-Gm-Message-State: AFuF++nhB4QI0vuyEy+zT1mBZjm3G8L23I7G/nahBkF6/0V7hWUBj8RL
	JnKgntpCt75AZGL01jpt65JzM2rPfKHYFEao4ta+4g8j1qeOt9UzG06Q6KuKlVyv9wcPnCgTPrn
	OviA3yBWmVj3cwztfN0Jl5PrUNHOM6ECkSNLx5PtkZXUKjCL7jzNdvZWGYmM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2087:b0:6b1:4e36:fb80 with SMTP id
 006d021491bc7-6c7d1ac9aaamr5783579eaf.15.1789628342287; Wed, 16 Sep 2026
 23:59:02 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:59:02 -0700
In-Reply-To: <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aab8fb6.71f81b7d.278072.0019.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
From: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	iam@thechris.in, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com
Tested-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com

Tested on:

commit:         238650ef Merge tag 'powerpc-7.3-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13824915580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1493b925580000

Note: testing is done by a robot and is best-effort only.
