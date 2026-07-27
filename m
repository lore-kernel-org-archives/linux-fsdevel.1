Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE940D592
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157390; cv=none; b=hw4mutpji7K+K07FusOHNCXbim5UvesIznvryk7GlJzLevgRW2pGtDZyIhfdxgPBHrjhegaHSVj6dI1VrPLiY/ImlHJ/5T98PIE7vuvC/inyIleffiJmhngaLQ0uz+uUql4rs1cQUDW/oP3Mf/lDpZ9rKU18WiXfYOF8uCj0Hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157390; c=relaxed/simple;
	bh=zS6b2JoVb7nseqJ2ddI79TDTJUXKZDgYnRPOQXP0Eug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IDsveHpwRsdCt0FThKZ5G795z7CJrjhEiEAtTPvSgm3t3Ybg7D8gZ57/PROn53//j2Rc7/MuTzMtRYLpBnuXssfcIV8wbK6btLmQ1xmzziHiduYKyee7ddhivYWM1s/dWROH4vgifCXDceYhOju5h15eZR6fVQ4yKCoQCuwv9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a516afd714so2590938eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 06:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157383; x=1785762183;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NDzA112ysxFy6ewvLv746I8Ostj+7rzN7xO0v+/DVpU=;
        b=rMcHYV9hYJD9Ha40waqtIczOqbkvXnj4VT3gEl8LJjuvzFrBn/2OsGbUudOhzom2AF
         MIa3opjxBIRXzywLGpzWMXb26ta28NQVcLD7o0LJM+GjOPQ4TkSx+y5HgPCRU8c7Wo86
         w9ynjCrdLUiZfVhRJiKLWN6WymNGPyNadCkrctHBe3CJoFnI++4B5aB5VUVkW0iS/FME
         1WincjyoJCg20LKMjaSytiw+roc0Ef0D21tIXIig5/fcO28Jc46JdBRZdiWJwOzvaMoZ
         pqeYyw8e49rFTpze0xfZ+uOvaOsdpRZ6nkDo3s4gry7IEsJ8YIjknyIOWscFZOR7exbK
         eAtg==
X-Forwarded-Encrypted: i=1; AHgh+Rrqyn2Lxy352TyVTTO7E1BdU1ixSRm53E5ogTP/yw8S9ZAXqgwej2E1iAk7WwW+CLf6NPq0AomsZ5+z07a5@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7BiNQ7ZXUqS19Hh/0e+M4VcPtB1hm9b5thIwik0nD2nmtcxL
	FG0Fppxha/xYoKI9edhpCA1eZ+tuGs9EnKbH3tf5Ua0/6R5NU+caOI+XXNUNEXI8mVBKckrdQ5k
	bOKpBBsU3JIF/HQTtQpeV58rNXFmMk2eFhG+xz6NpZN1VNSEspR5ht2cssCo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:829:b0:6aa:ef00:d568 with SMTP id
 006d021491bc7-6aaffca4991mr5776702eaf.33.1785157383139; Mon, 27 Jul 2026
 06:03:03 -0700 (PDT)
Date: Mon, 27 Jul 2026 06:03:03 -0700
In-Reply-To: <1098525.1785155757@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a675707.073198cf.94f0f.0031.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
From: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
Tested-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com

Tested on:

commit:         6836db8d netfs: Fix folio_queue ENOMEM in writeback by..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=170d58c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d69870d5e052935f
dashboard link: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
