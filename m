Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31613377550
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931325; cv=none; b=RXtJayP2+0InN5FDHTTam7Hf41Sq3Vkd5k9yHevY4ywsjZJ7Mu5JvOPcbRrIXuqdGVEQD/JwCmudnPxBsxZR4vXp5mz9dzg793Ce3iweggkk34Jn9IuVT8Jx5UqNeryl9aKw6BvmbP5HBk1PzclMAbnLwnMazVDaRpEw4S3DPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931325; c=relaxed/simple;
	bh=Ow6ytAqwNRGQ+o252H5PAFOkSl4Gq7Js863eLoNkPvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjpVI+2TLZjGvGuRwsY4lDx6DH0ijZATiji/X6lRV7llENRI1O6qiVCmYGg2zu2uGxc7UJcFEoMZcTlZjd0o3DJS9rzPktOOsueMZE/IppBhflRY82eTnLHyEdci+njA9ZmuZTpG0VGXEUI4Seuj4mC9bwj8Udm8jId/EGfxazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzaYSO1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzaYSO1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D39C116D0;
	Tue, 24 Feb 2026 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931324;
	bh=Ow6ytAqwNRGQ+o252H5PAFOkSl4Gq7Js863eLoNkPvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzaYSO1Peu1rPR7j8BJZ9K5pXlWmSFRJbAi1FBtkHOPBUfBDi0cOGKKlfuOypTlG0
	 Hg+yGG+rLioR9iWcE0HNJx79t7iVo9+zf7/UCSlN4kZyX+NnDavjVZMad82djMTmjH
	 z4/zq1HjjMl334Xn20rN6XthkKvts/5RUJY+vh/kNeqUbsX4ndUZkYQFjKhaYr3AmF
	 EqtYSuVoTzqL9vaEO4zUCwx4Y/HWS1Mbghl7mrWNTHk5zJzH/W9gp+5qtXT+Y7StBQ
	 nvPa4iWWJZu8OrKClw/RvVdb8wSe+c6OOOBXzdqJcsv84vK8h2uqkxLlHiFrVejZou
	 Bu5InCecYkBZg==
Date: Tue, 24 Feb 2026 12:08:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls
Message-ID: <20260224-ohrfeigen-kurhotel-34f7d21f4487@brauner>
References: <20251117-eidesstattlich-apotheke-36d2e644079f@brauner>
 <cd2153f1-098b-463c-bbc1-5c6ca9ef1f12@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd2153f1-098b-463c-bbc1-5c6ca9ef1f12@baylibre.com>

On Mon, Feb 23, 2026 at 09:50:13AM -0600, David Lechner wrote:
> On 11/17/25 6:36 AM, Christian Brauner wrote:
> > We have reworked namespaces sufficiently that all this special-casing
> > shouldn't be needed anymore
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/pidfs.c | 75 ++++++++++++++++++++++++++----------------------------
> >  1 file changed, 36 insertions(+), 39 deletions(-)
> > 
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index db236427fc2c..78dee3c201af 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> 
> ...
> 
> >  	case PIDFD_GET_USER_NAMESPACE:
> > -		if (IS_ENABLED(CONFIG_USER_NS)) {
> > -			rcu_read_lock();
> > -			ns_common = to_ns_common(get_user_ns(task_cred_xxx(task, user_ns)));
> > -			rcu_read_unlock();
> > +		scoped_guard(rcu) {
> > +			struct user_namespace *user_ns;
> > +
> > +			user_ns = task_cred_xxx(task, user_ns);
> > +			if (!ns_ref_get(user_ns))
> > +				break;
> 
> I think this code is a bit misleading and could lead to unintentional
> mistakes in future changes.
> 
> scoped_guard() is implemented using a for loop, so this break statement
> is only breaking out of the the scoped_guard() scope and not breaking
> out of the case as one might expect.
> 
> I suggest to change the logic to avoid the break or at least add a
> comment pointing out the unusual behavior.
> 
> > +			ns_common = to_ns_common(user_ns);
> >  		}
> >  		break;
> >  	case PIDFD_GET_PID_NAMESPACE:
> > -		if (IS_ENABLED(CONFIG_PID_NS)) {
> > -			rcu_read_lock();
> > +		scoped_guard(rcu) {
> > +			struct pid_namespace *pid_ns;
> > +
> >  			pid_ns = task_active_pid_ns(task);
> > -			if (pid_ns)
> > -				ns_common = to_ns_common(get_pid_ns(pid_ns));
> > -			rcu_read_unlock();
> > +			if (!ns_ref_get(pid_ns))
> > +				break;
> 
> Same situation here.
> 
> > +			ns_common = to_ns_common(pid_ns);
> >  		}
> >  		break;
> >  	default:

Good point, we can change this to:

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1e20e36e0ed5..21f9f011a957 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -577,9 +577,8 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
                        struct user_namespace *user_ns;

                        user_ns = task_cred_xxx(task, user_ns);
-                       if (!ns_ref_get(user_ns))
-                               break;
-                       ns_common = to_ns_common(user_ns);
+                       if (ns_ref_get(user_ns))
+                               ns_common = to_ns_common(user_ns);
                }
 #endif
                break;
@@ -589,9 +588,8 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
                        struct pid_namespace *pid_ns;

                        pid_ns = task_active_pid_ns(task);
-                       if (!ns_ref_get(pid_ns))
-                               break;
-                       ns_common = to_ns_common(pid_ns);
+                       if (ns_ref_get(pid_ns))
+                               ns_common = to_ns_common(pid_ns);
                }
 #endif
                break;
