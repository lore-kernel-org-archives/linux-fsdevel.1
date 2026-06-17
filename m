Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D02380FDE;
	Wed, 17 Jun 2026 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703796; cv=none; b=qHvZNlsAebrvVaKvci2nufwCqA4isk/MI5WLMg1Wi3c8Tcis7ie1HIZZ3xGlVSeT6c0Sdw3APnsyw+FTCLpeKA7ToczIsZ5/fj7uLahQo+tpO17g2XinfoGRRS9Rhd7eXFaCxgukHXMci5sZpMGmtk3Y6HEM3UyQmNVABsccoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703796; c=relaxed/simple;
	bh=3uERVTjIimoZc2s1jUzRoaOCQTFaedy/4LdbeNOOXLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGe6LZyCvZOU+2r7UJ46Z3efg3gqXFgKy9RlJtQ+OqyZgpcYO9IhhWb6sXYesXDZ8iqB8sC8hX03WRLGIpYcQhxzPKydgCbYzReIkc9ZuOZv7szI322GLhxewJ1eESJ4a5X2Mv/6f0wRlcOzvx44IycdAs3VA4nK4K41OaxSw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYnkXmG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYnkXmG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54EE1F000E9;
	Wed, 17 Jun 2026 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703794;
	bh=6z7dazl04WxxoaHeuIfjtYterbKqqRTCqIpiv20qH7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VYnkXmG2euK5sraJaAHz+XLdAm9q/P5ueQ+LQlwlsVuz4/DFiYgOafvY5ti4MUPcn
	 wnZsB+3YtiOFkTyni54dAeVilE6jv6i0zS7Qk2aUQ452Z6vsg5fzS4Hv+Rq8RJUa00
	 mCnFYYcxEtkp0ZtmyMQqYo5eFhEhoE2CoSk7GwMFceU/O6g24ATcezUiH6s1LEcMZ+
	 dZOPxSXBVvWtedtOqTMqOlJfzmKF98pyZBhcn910wtjbVnh4W/PzPat3tWg53E19mJ
	 5Y79RL1PprgIVBo+qRdE3pVysE/7rOZTHfqCSmyYiD1v552hO4OVLolCNbTZk9uiaq
	 AIAXgZAAXucKg==
Date: Wed, 17 Jun 2026 15:43:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+2cd473471e77bda12b0e@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] memory leak in path_openat (3)
Message-ID: <20260617-befinden-essverhalten-zerkleinern-aa706eec98de@brauner>
References: <6a2cb238.be3f099c.2836ae.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a2cb238.be3f099c.2836ae.0006.GAE@google.com>

On Fri, Jun 12, 2026 at 06:28:24PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2b414a95b8f7 Merge tag 's390-7.1-5' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=157e78ae580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4044c5352cad3e68
> dashboard link: https://syzkaller.appspot.com/bug?extid=2cd473471e77bda12b0e
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131d98ae580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14838986580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/86194cb79270/disk-2b414a95.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/11136f1a297f/vmlinux-2b414a95.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/809371abba53/bzImage-2b414a95.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2cd473471e77bda12b0e@syzkaller.appspotmail.com

#syz set subsystems: io-uring

The path_openat()/alloc_empty_file() backtrace is just where the leaked
struct file was allocated. The reference leak itself is in the io_uring
NOP opcode's fixed-file handling. Looks already addressed by:

"io_uring/nop: fix file reference leak with IOSQE_FIXED_FILE"

