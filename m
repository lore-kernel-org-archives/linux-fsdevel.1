Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33E39184A;
	Tue, 24 Mar 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341869; cv=none; b=MD9Hzy76FcPNjbmT2YqrIMdqffkI977VxQ7l1s6rByjHt/KAznC3Q4Nbh2y9erGZLkG+T6oh099hmZZWOUdbuDL07Q+o//xEiwgPa2cCmidP7oBx4CLf8jJ27Xwb3qQOyc4RzZEupLL0VTUeg3doDZw3tU63pvl9qaRhAT1zV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341869; c=relaxed/simple;
	bh=aD7bukCzsZvOC/XmwerazoW8g5boX8UXoP4hcTDItuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHAVMkbEDJn4U2Y0qV2Hj51V+k4XRmyj43NpYMDb7BCMOmKyXUOIQYeDLqU4H7lufkChHVs31e//387y+gu4anEC4WdM25kjxMRqynwHLPUZyq4W0IMJgiSdgxanGpbTdq/fR83Wtw81kNZv5EO/hKFJHsOfOokMri0AeddBD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKHDwqzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKHDwqzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FDAC19424;
	Tue, 24 Mar 2026 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774341869;
	bh=aD7bukCzsZvOC/XmwerazoW8g5boX8UXoP4hcTDItuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKHDwqzYhecbBGbAS2l03i4lEIaEtXnO89eO6HOsqH4XpAA7ir1TZUFVTzW2TFGTd
	 KtJcnKkTErUl2kKbFYpDkoAe1cRy7oqs+L6h5c+F37XrpQbZxkHfaDiZGY/ktTaPQG
	 E92rVan/uS3RAxomNPdsDH5UKZwWXYckUiqtkNH/Ce8N9CWUQdIijbSZo7HnCY2xKH
	 IWgAuVPxVIr5feKXoTb/tmyMXKXdujon4nY7P23XzZzBEL9IzQCuRMR3odi4tBYx3T
	 JfpaSydDd1PFCKJcs72ggv7E1pd7MA4U9ag3gLngD3IWAMJdUBJir//cURx4H1X+Fb
	 Y6Hg47ZZq2BqQ==
Date: Tue, 24 Mar 2026 09:44:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
Message-ID: <20260324-grauhaarig-gedeutet-f7cb2f86e1a6@brauner>
References: <69bdce08.050a0220.3bf4de.0031.GAE@google.com>
 <20260323-nieder-blenden-fdae2cc3cf38@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323-nieder-blenden-fdae2cc3cf38@brauner>

On Mon, Mar 23, 2026 at 04:17:48PM +0100, Christian Brauner wrote:
> On Fri, Mar 20, 2026 at 03:45:28PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    8e42d2514a7e Add linux-next specific files for 20260318
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10808cba580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7f5b21566f9d8af6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eb72da580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/cb90c31a24db/disk-8e42d251.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e0c08a5de437/vmlinux-8e42d251.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d6b18a5e03f8/bzImage-8e42d251.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
> 
> #syz test: https://github.com/brauner/linux/tree/vfs-7.1.mount 14594a141c760dd4c462b38d73406e1b48e44b84

#syz test: https://github.com/brauner/linux.git 14594a141c760dd4c462b38d73406e1b48e44b84

