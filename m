Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EF3815F1
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793224; cv=none; b=mQ2QQmIHF8HV+T8dSOj2OybJORjP/ZGjCZV3NYqApb58fSg6PHcroTyByWm7kJFSUphtodnnrDzSgwzUC0NDI56HeQkFcK88+WO4tldVT18cQVYGIuI27ls8VtJJ8yJySoGcWi8NTbjPv2+r2/P4k1OWA/0/zlLvuGZPi8qu//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793224; c=relaxed/simple;
	bh=dQDsf+lnB12y0SpNqzfHvLdMw7aUfNOs/Dr4p1hUpCM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u7z5c91mWPJicdurABq5ZmlXJe5cmbcYmuz3CgwmqO1oQFvd6rlbMXboeLGEe8CNYUyvvl3O3AkRZhb2LUEydaJglz05yR+lHETxudO4f5pebZQvN5owxZUf7xPxEho0tAAOaToQ0d6h2hcPv0BhVyEhK1n4VI97/9a+UJloVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-696906dddbbso2005680eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 00:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793221; x=1778398021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+osliUaymIVFH6R5/bEjn0M5p7u7//4ClVsL93EMMI=;
        b=hw5n8+Uee1qxwwbnrlEDTVUzQ7Gh7GTGSyiKO4jKM/C8upVYInh4IORy+R0MzH7wt+
         SSi/KVT22uZACZ/vPREiyB21+tC+4xAY65kvPJPTRUskG/V3Io4k6mQxTksG9wjyusfD
         pcMnfjo4c8lFD2B0nUqP7brfbSPOOtSDI3Ck5kUEEyX5z53OrYi6KCQSs/TL90rpuO5q
         XnvPyecREE9BhZzmJ6NvLxvrSrSpmmTLBkfJ1B3157NzEhvXvlKwBoF73rbqk/G3WXkW
         bPLf+57ZuvJYMZkNOGSR2iLlO7D8N2pfJbGccpi3P0+GJQCN6DvIFhnYuaFCxpo5G1i4
         gDXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gD3YwO4ZhZhsj45bL+FXI2bHp7W+/WPWnATP6rPpqg3sWHNQbLpCsPU/j0kSFOq8oKv+n2W+NDeX49zxU@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYscsr6S1cWnKSrxMYzQkDAGDzn847uRXnJNj1swZYysU7Z1N
	At1TwWj4hZn+OgpWU+j+vOxmCge0TvHiZ1hGDVHme4WW3Yzic2k4ScgZbteRqNIKoiVoFSPVHbn
	BlRoBWdyQE/wwV8k7gLQo2OkhWY3U3RhUjl67coWx2EFUS+abUxV2bspy3vc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1626:b0:695:94b4:d4e2 with SMTP id
 006d021491bc7-696979a4e5amr2197059eaf.5.1777793221036; Sun, 03 May 2026
 00:27:01 -0700 (PDT)
Date: Sun, 03 May 2026 00:27:01 -0700
In-Reply-To: <e50ceb6c-4239-4009-9578-51ece89fdc77@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f6f8c5.050a0220.1584b9.0044.GAE@google.com>
Subject: Re: [syzbot] [mm?] [exfat?] [f2fs?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: dxdt@dev.snart.me, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Tested-by: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com

Tested on:

commit:         66edb901 Merge tag 'v7.1-p3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fb7082580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f2f326580000

Note: testing is done by a robot and is best-effort only.
