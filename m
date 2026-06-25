Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13B2ECE91
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393364; cv=none; b=WgIsKtxn4bVrFjKdeNxQTWRysawUAJhvMNytQua/SGAF7Qd9jaBQh5WWCujQo2NfaHfw13jKVGqvieBdKG9cxaeT40V/3mCibl+eN2J4Fj/mE/5+3ohr3nZO54lMk6BEt5w58eUfzQXoBi6r5zP7GZsDD4fmEV/sBSMqa/Hc+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393364; c=relaxed/simple;
	bh=Av1nEaZBmzPeHVFU/YbHp35FNcszR6QBo3/rp5SvLaQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EF64moB8tWHyrBefGYLsFRHTDmzLLmqZHecoOeOlmrZlQR7EPoj0Yd5JOGY5AOGZQroNOSkWyKfT0QkPdjheTYK2uIZ/ln0t/hhLn8jR7JeY5FwsLTe6B3mz+0VEJT3ILGMBtxEQEGf4NLj1mmS1lK2yC+s9xfWhjzWgW4OYrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6b5976d74so2866421a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782393362; x=1782998162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7VMIbtiM5CsO8L6BOnyEVirILtl8EPmlTi0MLNnwpc=;
        b=qzbSGHDpza2b31J6BpDNxyF94PSIgZuE0UKfF/jYWeTdDS4P5acZwmRmtefp62x9zF
         T7FlhOjasm2AiihwTwXw7AtKfOKzcPtrbsLY4WiYVGzqyJATWW1v2klzl6iSbVmWrjpU
         bneOPP25H5vQ7/QDt3PvmRtkUo3dw8wO97YWa3y0y74c9KKUiasOGv9BjHVeo5qgYmx6
         /9ssYodQMUMXNq2w0rIpP+HJxRjCpnPVgsHkoVSguSwPFIkqOefTQ/Fj8c9tdVF+VYvN
         D6fz+fHptivs7IAsx9clAF7jYG8YnGnGfH2dNlar1NYql6CS7NzyisuHjNgdxPK2QRFn
         /AFg==
X-Forwarded-Encrypted: i=1; AFNElJ+QlelKRVFHlN7N40wm3zSbxVRKi3J/m3fdNoqe+OgS+CRyMZVKNg+JW7cEEN5ba/SVrYha0zC1G6HGlljM@vger.kernel.org
X-Gm-Message-State: AOJu0YzdpQ0UrEHe0c500M9ziFYKNYPTkT1XvwTieqxwlp+iy0jWynx+
	+JlcWeVFuiso1PeieR++B3J9SZY8f0CYhLL9bgYyNN8MsIvzH0gzgc4AOQBIisT9KqCDG96cViw
	CI9GO41zDwemy7YVzozdKSetc/YCGeAJ5U7vk6AMMOsZf6GU8F37OAybzpW8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4c07:b0:7e7:bf0:d84e with SMTP id
 46e09a7af769-7e99c18978emr2870405a34.11.1782393361857; Thu, 25 Jun 2026
 06:16:01 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:16:01 -0700
In-Reply-To: <3106406.1782391857@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3d2a11.cf1c467f.2941c6.0006.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
From: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         8fde5d1d Merge tag 'acpi-7.1-rc6' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1553eb41580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1654601c580000

