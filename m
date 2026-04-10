Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A567262F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849435; cv=none; b=siW2kV7v7h7viaGOAwFA8q/DaxXseeQD2A1Bv1jQb8rMQ92EIqbVTem1xFmlQQDyUoyfZsQU4HwPUDr29GAhB/LDADn7SDW1+oev39RY7EswF5ZCCWma9lktxZXbvCY79G1T7UdUNsPQd+AdZvgTOKmXMPe4zeKgT3O45arOqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849435; c=relaxed/simple;
	bh=PsWkoXW4A4uFQtV6jLP1+kN9WcEsTcl8Icm4YKIZm50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6bnp91ghRVVIp1tsypFOS9V80dhnRwsQ3IaOAT1/EJoBJXb2t/IiriUujHmEzP2A2xlyfbt48r3Pf51a2ZDIrtLNrbXu4gH2/uh/CmNRVvObOIc18L7whi50HZwKWmNTDzGo46tYnX2AXDrmYhxyYCfT65T1uW4SkEr/GkSvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e6Dq1zFN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e6Dq1zFN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so1222226b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775849433; x=1776454233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc6AWOx/R8GQDJoF+qZzIv+0vdUTUu7zX9KRlbwaTyY=;
        b=e6Dq1zFNa4C/njaNVbG8tqB9by3TTeUnJROZTzV+X+r5i/PEM3cPUN2jblTiQH0WLc
         Gb/SRedosifz8UsqGSGSiG2kzrONWQfreNXynVTcEp9IRz9HBQpJuKR/QwntE/FfP37B
         UfPPr0cnluI7tWMlHEudp05JbgZzoGyNzsmfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849433; x=1776454233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc6AWOx/R8GQDJoF+qZzIv+0vdUTUu7zX9KRlbwaTyY=;
        b=eqX+ZLb919saq2tppafwW7MMlVNsdlUadaldaWGTaBknTAVrv3j0m2OuttJfSCU2Fi
         0g2TPu2j+PAjg+nMoKCxKBXiOSjwaPVc9ugb38f/p6f8O8f70eRyvExK6hxmtbp2yW4h
         2NGKyFoWvOJ8Bg5ZAHEdIw45Rf+Ar4efz4jn2dQSICa2+V6g96iYPTQeY3p6zcZWadr3
         I/1hL3X4BcxtysK8LiR1A7F2DUn7onCEPtWwLcpRJuSJFZcHlbgI4G55qFkao2oHQirl
         moxhpvdrpPGmtFoz6NAiO4d1odbZgiXgfS1Tvv7AyolYcwQFw8gSEk3dUU2r5ksl1e0L
         pylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeWjnvwdRzj0l1XBEBXb+kgHlzoWTKCgLuHgYjX2vE+rehxjARt6hPQUCx1Y3IitdmL+J1E017mxMvy+i9@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfXBdwQfA5L+OJI4zO8OPn8C/GsbnXOW1CXc/gTxbPmSGcPSm
	V0FHCR17tV1WcJR/fn7kUBsxY93dBaT1xbteoQfc1hdpvUTZlm5FKMvpCnIPEse89PXxy1Q9gOH
	Tenj11t6AiA==
X-Gm-Gg: AeBDietz8a9HKj40tmGv6eNC4Ckm84RLWDrFYfG9wMbMoHMXU8qtHSVog+CXTo4zBdr
	+Iy1C2xVEB9Y4HbbRDfBYu9SOBhE1uq7Gj8UoXAdLUAgNSyhfB9TNTWGQgHe7Ge+h716htz23aY
	iVaXCRxmASc9o4rDDHO496/pgRn+WJIVSwIe+o5h0dGCydDPkhNI8uGLYWBDcE7UkLndGY8Hnyj
	AjrO1pGfQH5S+kMPy0KKEeeliCKxfFHxMaFKkmBpg3vcAXRVrOzZf+6V8aliNXktbn//JiTGmsK
	FeAjwxNzKWDOW2b1LK5tWUyA8U+lf4XzvHLaQRyafRXheJPnxn2us8SBSLgh+Vcw5qoIsRTk8Ey
	lysARKZB7wTjNbhb3wt3n49UFwPSCZBBjkQ3dvCCevAQGB4++1MYUyl9bAVwPUZVgFgFNq0kzpA
	7EEgtZ2zgaszm2WkGsxhDyDuJW0LQCI+GXTV/E9Q0pcmeO3m3ZE7MVFZWdMDVsGzbb8I8UvulM4
	EOG
X-Received: by 2002:a05:6a00:1795:b0:82c:ded1:2613 with SMTP id d2e1a72fcca58-82f0c15c30emr4768139b3a.14.1775849433262;
        Fri, 10 Apr 2026 12:30:33 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee59sm3758124b3a.1.2026.04.10.12.30.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:30:32 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82ce09b4197so1248479b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:30:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdsvGm9kJISihE973MqMiMhuLga/xMAanLoIKBz6Poa+dSK4/489HGyiqqoIpcib64ylQ7UliUQO4KIKIj@vger.kernel.org
X-Received: by 2002:a05:6a00:408d:b0:82a:8163:4bf4 with SMTP id
 d2e1a72fcca58-82f0c27749cmr4920149b3a.46.1775849431920; Fri, 10 Apr 2026
 12:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV> <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV> <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com> <20260410185243.GU3836593@ZenIV>
In-Reply-To: <20260410185243.GU3836593@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Apr 2026 12:30:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
X-Gm-Features: AQROBzAQAmKLea_bX00iaC7HyS9QoK53R9w53lnhDRklpcThCMJOW5cdN5GRl8Q
Message-ID: <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Max Kellermann <max.kellermann@ionos.com>, 
	Eric Sandeen <sandeen@redhat.com>, Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 11:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, I wonder if we would be better off with the following:
>
> void shrink_dentry_list(struct list_head *list)
> {
>         while (!list_empty(list)) {
>                 struct dentry *dentry;
>
>                 dentry = list_entry(list->prev, struct dentry, d_lru);
>                 spin_lock(&dentry->d_lock);
>                 d_shrink_del(dentry);
>                 if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
>                         // killed while on shrink list, freeing left to us
>                         spin_unlock(&dentry->d_lock);
>                         dentry_free(dentry);
>                         continue;
>                 }
>                 rcu_read_lock();
>                 if (!lock_for_kill(dentry)) {
>                         spin_unlock(&dentry->d_lock);
>                         rcu_read_unlock();
>                         continue;
>                 }

Ugh. I despise that rcu_read_lock() in there, because it's typically
completely useless.

The reason it exists is because lock_for_kill() can drop d_lock(), but
that's in the unlikely case that we cn't just immediately get the
inode lock.

So honestly, I think that rcu_read_lock() should be inside
lock_for_kill(), rather than in the caller as a "just in case things
go down".

IOW, that code basically now not only does that typically unnecessary
rcu locking (and then unlocking), it does so *because* it knows about
the subtle internal behavior of lock_for_kill().

In contrast, if we put it inside lock_for_kill(), all we need is a
fairly straightforward comment along the lines of

  "we're dropping the spinlock in order to take the inode lock, but
the caller may be depending on RCU behavior so we need to take the rcu
read lock first".

 that would turn strange illogical code that also generates worse code
into straightforwardly explained code that also performs better.

Ok, so "performs better" is kind of exaggerated, in that obviously the
extra rcu_read_lock/unlock sequences aren't exactly expensive, but
still - I feel it's a win-win to just do this differently.

Or am I missing somethign else?

                 Linus
