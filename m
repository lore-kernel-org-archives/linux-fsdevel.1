Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94A3F39D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155224; cv=none; b=DxUuZnRA/I90E7sK2yGmuJnVExFHVJ9DaAXgSzNPmKWU1B+SQtW4ZEJw4+zv3cjJrEcsmEJhLEufpC7JqqIHvwNqrjHyZS81y7pt05KsLbxe7Gpn3CxozWpJAb2iU3XIlrJzjjRt31YLk4MI+9xyMwITO34FnP82PH4HdcrD6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155224; c=relaxed/simple;
	bh=gUO/CcWK1D6oNtnuS3Yk4w244iY6313rnpPLKhs/t7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F6k9tN+txjrzXb0udkxzTpYQVOIyYt2g+y4QjXlpKuP+/okx4lPrsn4iKKHaJ6lyzrnkowXNp6Cx0iwrPwP5kCBtzzuF1LccjK/D15LXV5Ml0H0VJas8meulceoKsD4i9G2SbM2kEye0ubqD96zxX3NpgDMlZID0I0MKM2Zt6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-485ebc5706cso5019082b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155222; x=1785760022;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WaRX9BmsXwT/x48OgKFTtHEAv0wRi9sRmyTf3sNcLew=;
        b=Ga1wKp3JsQkkoPAd3N4e9mUMvJEMbpmkQj3mOo/5MKRrJKzNHG7lvOvGEW8n2AAIsZ
         /bk73zrtpTUwxHlQGZtrcTpLrA2zxKFSmhPeadFK5kRqrWy13AI/wBO5gr1/hH9wtQtw
         Cck4uKtrvUgt2UwgkZa0VBVLi7OT07WKh7mPTfTXnC1a7tO1yCmqYd1FzORxfxQ8OK2l
         rFbeO7wK/fCg7lkdeLtjWxuO0iCw4itR80Lk/Iuv/YjN+VGbYURKpRgvYCfjt1ixQ3nz
         noAR2KAoKLEnbAfD2+SlA9yZat7YsUAw7dedZk55h2LNS87P63w8/dzzeVyiWbTaPLsa
         PVPA==
X-Forwarded-Encrypted: i=1; AHgh+RrL3Qbz5WiYIF8uvHUj8OJptRHfxwhhOeTuG5Xl6W61EcJd75o2dCc0uF0KU8VHmzqsaPv41WtGvgeQl/gC@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHreKUjJpWHBgDyNxMFG80NKe/IBC6VLeJ+Bp2f4tYFXkHs6h
	lGzPQaOzeDvdAu4KNGc9gjrx45YrhBbcc/9OYgCflLHSoYZdp3ALMPKUSvA+Y/Y/FqgcizUMecs
	z0x1AiwUlsX6daXJu6JtnKjTFhVt5H+NkW7pTN7eCOql2c1W1FXhCKExqVPA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe2:b0:4a4:c13:707b with SMTP id
 5614622812f47-4ab5e50e439mr10467776b6e.17.1785155222099; Mon, 27 Jul 2026
 05:27:02 -0700 (PDT)
Date: Mon, 27 Jul 2026 05:27:02 -0700
In-Reply-To: <1097630.1785154821@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a674e96.70955b6c.323240.0042.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
From: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: patch failed: fs/netfs/read_pgpriv2.c:53
error: fs/netfs/read_pgpriv2.c: patch does not apply
error: patch failed: fs/netfs/write_issue.c:749
error: fs/netfs/write_issue.c: patch does not apply



Tested on:

commit:         f5098b6b Linux 7.2-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=0da43efa72f88bd3a8af
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141558c6580000

