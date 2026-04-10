Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E4CA4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859321; cv=none; b=cf3E3ElVwurn7/y3Ez+tSb4UiqwgV7Ne7k3ffoDcg5l5QRUMbULbBi2MxqWgXoD+ZHOahN1zEAyTOOTatKRAgdAq3g/TY0HE7DQSNHJceMnc8VHFWrfL/B8u+Wrd9pBvLu1yibv7gMewhy0euc/yAH7XdX8T9FoCJMVju0gtfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859321; c=relaxed/simple;
	bh=gdgSrLGW/VaEiRmpoGAtvWDHNlIQNmsYKN1Ph0YK7sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ0MOebTUpM6i7U3B7LSLbS/m2Ch14aVsTir8lFW+AEMoqwqCSOdzXWWdQis+vifroQzVR6fNTzfuoReGEAOCHY84KC42KGDEJDF0xJt+EcJO+fgjEvzzNkZwAbepwQQHKercE4s3ExOodjUplmV7V0z0q/zdjZtWbryYTQ4+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=frOsbES/; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="frOsbES/"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c287eb77fso1565664c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1775859319; x=1776464119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZElh/vhz7cLO39kZK9jA2M+QKGuPYEoNtEy+sxO5nM=;
        b=frOsbES/dx6V0Bv6ZaMVi0GqgD1KzX6uyHYn6wWae6wXW41jQ0i0VVa9tIjJVLbtMd
         oflSgKLQa6aUYsoutlAfBiBw3f6rFz0PdJXeu9uJCRE6JCm5jGitrQVa+xAfc+v3nA95
         KQyiX8yg8b99Q+Xl5zSaiK/NARYaZeJ3ZFlJrKu6sKY0mrMssZAnd36f0iJccm33K/UX
         Xmklg5V2b2DsiNj0E3SNrexabiGsKjXEtgisQOaLAeBjCVnfGdK2z/6e3USnOU6TNiCW
         XFfSwWsj/NlZSl9muCdfmzkQiER9jbLCk0GdpOVvcldtJnf5m4P2ncRJzA93WllWjQXX
         uHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859319; x=1776464119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZElh/vhz7cLO39kZK9jA2M+QKGuPYEoNtEy+sxO5nM=;
        b=bvSgfzCYfeDwusWoFfWwfXIGkv/xrQ2ZqcAuit4+q9xerSruNg9ncUunI37fkFh3ka
         +TYpMFMMzr9lOpfjOC9E2lFpKP/gjGPU/kypTzt1/hez1Z5mHzNLK13ImttEh7RFQEAX
         Lgqt84tSf+B/g8VXuFNSo1GQSOyjbAAsrAG3lEQpJD+W7+4t4+WkV/VkMVnnSt7CpIbw
         d2d2voUO8J3QRtfEvFu54xhELdKAJAjefmjornySzwJPxO/M8xXsEIaZoWoXokRg0boh
         GdSW3OUS+Thc5GA+BYO7N+AodUNTJnP6VBfXhyyOdCt4s8jH6TXAYTxCCDp8z73QCFuc
         4lpw==
X-Forwarded-Encrypted: i=1; AJvYcCXnUNc+dV3fMTcRbnGEnr4FWyROvyKOWPhiarNwTzwDZ0g86PAV3fOvAxVW44n6BbqQHrE4nZtAviENObOk@vger.kernel.org
X-Gm-Message-State: AOJu0YztZEbb1o6w5q/rMIq+R2uQkOogaaAWZbzzRAKiaCA/pjolJuAn
	qGl8kBHV0+NrpFIZZun0J7BD7xaiWrRO42daOd0qk7xZmJcUDh4fk9mTCDos/I2fv9o=
X-Gm-Gg: AeBDiesoDrvALmc+oiCG8m6uE2QDth1anzEcslCaVvwPVApJYdHrGUD4ICUaJtO9H82
	/eIqg4n1Mzws4R8wbht9ghdNZANO0xKz1AJE665WYJgtiFBCH5I9QJWwmj7m8Sm50l3UxjakKRw
	YzeZa5Uw69+D9raYT1U9mOrhbX64LDZelbBqWtIuNUshqvT0oOfHlG32Cw1XhQlxXILEuP/HkyW
	99J9I0UbN6xCX28IYiS+MvrOgcVJqa6i9BKkhql4mg5QDXzFsg4E8br8WnJgXjiZM5p375rGgyx
	u6THqGYC9cig1CI7OyMi/z7YQnx+YwqnMG97KovX379ziip2GSUfB95PXH2ZQOpqPtk7eVLLQCU
	yPrYtzyTdiA7r2ZpvweGlLHU2NFIgswbaVC1d9SnoF4HeyWvkFZpORom6zWN0M08/Gt9U1YcRgG
	3PvgQM4WeSLc793/QJVArUB6rHsw==
X-Received: by 2002:a05:7022:3d12:b0:12a:949b:b9b with SMTP id a92af1059eb24-12c34eedbd5mr3071543c88.23.1775859319270;
        Fri, 10 Apr 2026 15:15:19 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:c494:2bdb:81fb:43b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm5087216c88.3.2026.04.10.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:15:18 -0700 (PDT)
Date: Fri, 10 Apr 2026 15:15:16 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <adl2dMjN2hmVvORh@mozart.vkv.me>
References: <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
 <adln5vp9HFbX-oz0@mozart.vkv.me>
 <20260410212403.GY3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410212403.GY3836593@ZenIV>

On Friday 04/10 at 22:24 +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 02:13:10PM -0700, Calvin Owens wrote:
> > On Friday 04/10 at 15:32 -0400, Jeff Layton wrote:
> > > Yep, not even with that. One thing that claude pointed out: doing an
> > > mdelay() might prevent it from making any progress freeing dentries.
> > > I'm experimenting now with one that only randomly does a delay, but so
> > > far that hasn't turned up anything. I'll let you know if that changes.
> > 
> > Hi Jeff,
> > 
> > I've been poking at this one too. With the attached reproducer, the
> > waiter will get stuck in an infinite loop apparently in d_walk() with a
> > stock 7.0-rc7 (in my case with PREEMPT_LAZY):
> 
> Interesting...  I'll try it in a bit, but just in case - could you check if
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-busy-wait
> steps into the same thing on your setup?

Hi Al,

It still reproduces on that branch in the exact same way.

I'm absolutely 100% guessing... but I recall tomfoolery with the "magic"
symlinks in /proc/$/fd/* in the past... the below patch makes the infinite
spins impossible to trigger with my reproducer, does my explanation make
any sense to you? Apologies if I'm off in the weeds...

Thanks,
Calvin

---
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] fs/proc: Implement d_weak_revalidate()

I think this is necessary because ND_JUMPED can happen in /proc when
the magic symlinks in /proc/$/fd/* point to files in /proc. If true,
this is a problem, because the default behavior for d_weak_revalidate()
is to assume the jumped-to dentries are always valid.

Fix by checking the in_use count in d_weak_revalidate() for procfs, the
same way it is checked in procfs d_revalidate() today.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 fs/proc/generic.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 501889856461..359176e5eeb3 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -216,15 +216,26 @@ void proc_free_inum(unsigned int inum)
 	ida_free(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
 }
 
+static int __proc_misc_revalidate(struct dentry *dentry)
+{
+	if (atomic_read(&PDE(d_inode(dentry))->in_use) < 0)
+		return 0; /* revalidate */
+	return 1;
+}
+
 static int proc_misc_d_revalidate(struct inode *dir, const struct qstr *name,
 				  struct dentry *dentry, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	if (atomic_read(&PDE(d_inode(dentry))->in_use) < 0)
-		return 0; /* revalidate */
-	return 1;
+	return __proc_misc_revalidate(dentry);
+}
+
+static int proc_misc_d_weak_revalidate(struct dentry * dentry,
+				       unsigned int flags)
+{
+	return __proc_misc_revalidate(dentry);
 }
 
 static int proc_misc_d_delete(const struct dentry *dentry)
@@ -233,8 +244,9 @@ static int proc_misc_d_delete(const struct dentry *dentry)
 }
 
 static const struct dentry_operations proc_misc_dentry_ops = {
-	.d_revalidate	= proc_misc_d_revalidate,
-	.d_delete	= proc_misc_d_delete,
+	.d_revalidate		= proc_misc_d_revalidate,
+	.d_weak_revalidate	= proc_misc_d_weak_revalidate,
+	.d_delete		= proc_misc_d_delete,
 };
 
 /*
-- 
2.47.3

