Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B19329E46
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774732493; cv=none; b=P1he1zGROuvsm2KanoSraTUs/wXBUVXzWBJ9+wZGdKOU88DZc1ukm/r+yYyzbjnLarHCoBvc0yakJwwNTS1CI5XE38ROrWSo1IbhCftg1Pb/et38QktfgorGV5yuXmQICluxk9UI2oyXK0mO6AK8zHITtSLVnB2fCpQ42x7uBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774732493; c=relaxed/simple;
	bh=x1KF3VUvJKMnwvgJtqvORA+nBgN1MElN1B3pDqoD6bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOitDvIge58TOYBHMJSbDy6jvNpBXcVYq9zUUYPW2Han7oHIHE1ceYsDOtJZeo67CiFnesTtNy+4HzoamvDxHOjrDYlXbCknyiyuiaeZHdrGGfF+Wf5MxW1PBhuK5kyPE2ZHpBNwY62AomJARG8K2CtRE/bYe1I4aRb/az78Eag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=XqstIjCm; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="XqstIjCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774732487;
	bh=ZUkzZ9D1mRsmvB/2kqeiIBOtgxxGGWnSEDpz4d1SVqc=;
	h=From:Subject:Date:Message-ID;
	b=XqstIjCmbkmNLzgFqKllopqosChG13m044tt25IE0KmnGOJP4xZWCdRiozjnTK6m1
	 aoRcLzYqy2K9Aciiyj9zvCoLWUqJpzLj/Qw37ffZxXdcjpbTzTkJ+SH49gnmfAcsPz
	 bJ5RIEy7H4/iK0mW1BBy84XndF5Ib+d/tH27BYII=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 69C8437C00005DD1; Sat, 29 Mar 2026 05:09:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3162436291843
X-SMAIL-UIID: 562DBEFB91D646C29BDFBE4581DE689B-20260329-050919-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
Date: Sun, 29 Mar 2026 05:09:06 +0800
Message-ID: <20260328210912.1571-1-hdanton@sina.com>
In-Reply-To: <69c7d4aa.a70a0220.128fd0.0027.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 28 Mar 2026 06:16:26 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    3b058d1aeeef Add linux-next specific files for 20260327
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11bd16f6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4acce231a75c746f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dc6606580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15baca26580000
>
#syz test: https://github.com/brauner/linux.git 14594a141c760dd4c462b38d73406e1b48e44b84
