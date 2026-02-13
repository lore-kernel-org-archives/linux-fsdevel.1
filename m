Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750E2DF146
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979325; cv=none; b=HohuEchmDKM86E90ZH+Z1atXS2WNgFVRWesfi+OJGi6EHQalCX8uuz1KZooxW9yRdpqIHEmJL3TPEDpTPVmFzwGsPuvGwJUkykFrktC1qtL/cgZVzRVh7nIpKsYGxh2Satt/jEI/qWTixV0Dl7/xwJGwj9aiuOoG8YDW4tA3R/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979325; c=relaxed/simple;
	bh=tu3FIAq9qMCAcEKVg2hAsllav+0DXYBJG+4kr5bOBLQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VO+pcFKd0dovxxNC7gQscm6UZgC86F1Jh8WWh+7q+xwaNZeBUc3wshCKe0x85qmgTri63AhAtb7PbqMIqR7xKm86TguAyRklczGCbkSu0pPy0bAmfsqU20igHG5ubZ+XTC0isgdOfZW3K52u7F9pt+E5Ea/eAVEYWreai2K7bY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-677f78e66ccso61117eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770979322; x=1771584122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFQzNQR/qmPz49C0Lv5yYKa+CubjQy/ZMokykimNfyo=;
        b=wfUSeczJEeF1mT+D3GrWbrcxHncq5/nAoQ3EJbWnoZ9T9kulHx7HJmGBZMAAR9DPJS
         AkAkEqaTIlz0j3FK+3zWcQJogrHXf2Q+qgpyW0DPUzU4eHREmkUcCwmjBtPPXOF4h4B2
         yyjz6cv05S2ia1MpjBTachCwNKan/C2llKm2hm8nj7alXPNdQfESI2c9MxhBqJuH0e1G
         uLEk3aTrdRV3phLcnKSRfpADv6IQ0s/uWMymlafv3NCOWgj7Xwwt+1GssWQgGOHtew66
         yUheLx2OEXiB8Gv9tvG3TECWsCtYNMa9MkzA133VwvX+dzY1uU0DUeF+NaFa9FMmztcV
         E1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXqosK3OqHQg94pRqXhM0nqFZ7MOTXcTNj2NDXgmR1IOlMu5iHnvIgnukNlpi8ql7rC6j8EqYNo5sfOFuhg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9Q1RwC3LbAhol8rCke+pI9d0bC7oq0swXPE1N3y5Wr9uhhF9
	YOrlmrda4OmshldRePjSj63PSVnqBtt6IxkFBTjqsv4beNf8LBTWpWOXkWDXI0jNsim3foXNrO8
	ljxE77yZJETwtYIDHATTxN+tcChn4dSVGn/quSjRF3XQd1wLpNaRg012FN+A=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c89:b0:662:bf74:ebaa with SMTP id
 006d021491bc7-67768bd4a3cmr556699eaf.54.1770979322701; Fri, 13 Feb 2026
 02:42:02 -0800 (PST)
Date: Fri, 13 Feb 2026 02:42:02 -0800
In-Reply-To: <20260213101730.2466521-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698efffa.a70a0220.2c38d7.00c0.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in grab_requested_root
From: syzbot <syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Tested-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com

Tested on:

commit:         cee73b1e Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1718be5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe62ec9519bfdb19
dashboard link: https://syzkaller.appspot.com/bug?extid=9e03a9535ea65f687a44
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f6e652580000

Note: testing is done by a robot and is best-effort only.
