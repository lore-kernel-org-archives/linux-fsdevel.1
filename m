Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3B3ACA4B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273116; cv=none; b=jCJmInNzcmkhFIniZ2urBp5cjYinpCmbswJp6vgs7FoAFJCvpz3lIVatYR41hQ2NQ5JkAkd/DExMX+Gq0uoNevk6qD63EQmQwQANZCZEp9OC6yyUP3Is5kDA3IwusBO70jC/ywY2rIP+1wQEMPkwYBKsna3B0oVp1PzMADML1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273116; c=relaxed/simple;
	bh=HaVLp5dbH9Rjy5jVeHCgz/X7FuFbTbVtp/mUDNQEH4o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XunNjIffVUiDo3iSVeG2b3YTlExm0MVDoSht0qh4wxqGFZ3xB8Jlnk18SwLaEaIiWgo7RGNGL1ZNUmxkQwMxI2+swU9pXyWzla5O1ES9kphVeA9k9nNmHkoHzRNZNGqXZXZ5EMnesAxOkWaM6sOjKoB3FCzrVPYotPWybSvJUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62NDcKKL090101;
	Mon, 23 Mar 2026 22:38:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62NDcKmi090098
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Mar 2026 22:38:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <14a033fa-9d6c-4772-a322-15cb18feeedb@I-love.SAKURA.ne.jp>
Date: Mon, 23 Mar 2026 22:38:21 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hpfs: obsolete check=none mount option
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp>
 <4c2f1aff-b892-496e-9856-157b507ce5d6@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <4c2f1aff-b892-496e-9856-157b507ce5d6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

Linus, we are blocked by your comment. Please tell us how we can make progress.

On 2026/03/12 22:24, Tetsuo Handa wrote:
> Linus, which approach is acceptable for you?
> 
> (1) https://lkml.kernel.org/r/51bdd056-61dd-4b57-8780-324b2f8bc99f@I-love.SAKURA.ne.jp
> 
> (2) https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/fs/hpfs/super.c?h=for-6.20/hpfs-changes&id=a4664a2bc61c2abbc772df9139da9dbd2b26dc7f
> 
> (3) https://lkml.kernel.org/r/fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp
> 

-------- Forwarded Message --------
Date: Tue, 10 Feb 2026 12:21:21 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [git pull] HPFS changes for 6.20
Message-ID: <0a4797ab-07a5-11ef-074f-19ad637f84ea@redhat.com>
References: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com> <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>

On Mon, 9 Feb 2026, Linus Torvalds wrote:

> On Mon, 9 Feb 2026 at 09:01, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >   hpfs: disable the no-check mode (2026-02-02 18:06:33 +0100)
> 
> This looks like a totally bogus commit.
> 
> If "check=none" suddenly means the same as "check=normal", then why
> does that "none" thing exist at all?
> 
> None of this makes any sense.
> 
>              Linus

I wanted to keep the "check=none" option so that I don't break scripts or 
/etc/fstab configurations that people may have.

If you don't like it, you can drop it, it's not a big deal. The syzbot 
people will have to deal with it in some other way.

Mikulas

