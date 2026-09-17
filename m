Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF73D413F;
	Thu, 17 Sep 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640338; cv=none; b=ebL5cMhkO0DCToR0wIeXP2tjCuz5k8vG8sdTjeAYH/2HiSRBuTvuHUEEVwFzodLqpB9RuawxDR13fgP1lhvIspGZT9wfqpJ0AblxAZmRl77E+JRsKz06HkQGIHBPpwAh0A/RV8GLKXDzX7Qlq/UR8uF+vUA0thicFV4KU29tYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640338; c=relaxed/simple;
	bh=dnqgWmMlMT3rhhJvrxIw2SeqmOcqcGDKcUrL5VfGsu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnSyUch7u7/ZM5dDYTmA16Iu4zNPeo+lQgsjPVAA+Sw/UZyUcHznZbG+Fiw6YZ9EDHfumYly1f0TieG8mvww6GYrHKekxdl17OHA+urI9Mr2iA0LbjAJFsqiawU3RpC6ot7HezSv0WsXqz0RLK/4Ua7NeykGX4jtDkRdnddEvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpiILKlj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpiILKlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9C31F000FF;
	Thu, 17 Sep 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789640337;
	bh=8t5/A3M/pTDCbWt4AC8flokRJa2n9cF5txLr5EGOSNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cpiILKljPqDnMX/zM7jjXCFTWHbyn9UZrWBGgCRNpLjBQOugDiA5HE3ufmU6yloKl
	 mQ42/tcYXDuGnwFmRzjYE6HbJvMWAg2cr5X4aJ7iIVJ86MQ3WRor3gpLinsceG1ik3
	 /fkJYPczmlUiFUTtTV9msnykNWdZl2tH4INQD0x/pemuC2Z5GBcwMuhCQdtLGEHQV1
	 jJvUpsOrR3FhyZkBtL1K3tc1aoSgPpt6vlmJaRQl9NPpAPwDzOFLZNGZFqrLVUrOdz
	 s9zDHsAuhoAxfIlGLhfTo4kvN4zYrD6MW/4rGo/A5frjG6OmPFyTBuI+EVR9BO0LWs
	 1lLsuS17H+8jg==
Date: Thu, 17 Sep 2026 12:18:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+listec583fa4257875d46833@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly fs report (Sep 2026)
Message-ID: <20260917-ticken-spinnen-feilschen-d7e283e8ea2a@brauner>
References: <6aa38496.6e6c5f9e.28f11f.003f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aa38496.6e6c5f9e.28f11f.003f.GAE@google.com>

On Thu, Sep 10, 2026 at 09:33:26PM -0700, syzbot wrote:
> Hello fs maintainers/developers,
> 
> This is a 31-day syzbot report for the fs subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/fs
> 
> During the period, 3 new issues were detected and 3 were fixed.
> In total, 46 issues are still open and 642 have already been fixed.
> There are also 30 low-priority issues.
> 
> Some of the still happening issues:
> 
> Ref  Crashes Repro Title
> <1>  10972   Yes   KASAN: use-after-free Read in hpfs_get_ea
>                    https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844

hpfs

> <2>  8730    Yes   INFO: task hung in __iterate_supers
>                    https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9j368d
> <3>  2032    Yes   INFO: task hung in user_get_super (2)
>                    https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
> <4>  2002    Yes   INFO: task hung in lookup_slow (3)
>                    https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423

ext4/vfat/sysv/9p

> <5>  33      Yes   general protection fault in __simple_recursive_removal (2)
>                    https://syzkaller.appspot.com/bug?extid=cc460646984184ad435a
> <6>  26      Yes   KASAN: slab-use-after-free Read in lockref_get (2)

Both <5> and <6> are ic2 core races and fixed in v7.3-rc1 by b15b548d52b4.
They were tagged with another syzbot id. In any case, no fs bug so:

So both should get:

#syz fix: i2c: core: fix debugfs UAF on adapter removal


> <7>  25      Yes   INFO: rcu detected stall in sys_close (7)
>                    https://syzkaller.appspot.com/bug?extid=393022c13d02e1f680e3

NOT FS: taprio qdisc hrtimer storm via RTM_NEWQDISC.

> <8>  25      Yes   VFS: Close: file count is zero (use-after-free) (2)
>                    https://syzkaller.appspot.com/bug?extid=592c653b056459925299

NOT FS: That's a gaudio_cleanup() thing with a fix on-list. Remove it
from the fs list, please.

> <9>  22      Yes   INFO: task hung in writeback_iter (3)
>                    https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2

FIXED: The mdb_bh versus bitmap folio deadlock was fixed by f26da7e0381c in v7.3-rc1.
This is just reproed in multiple fses and thus kept open. Kill it.

> <10> 22      No    possible deadlock in uvcg_mjpeg_bma_controls_show
>                    https://syzkaller.appspot.com/bug?extid=2b082cefcfb1439289ef

NOT FS: Deadlock in USB
