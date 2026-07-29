Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14582853FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288058; cv=none; b=M3L1hNQItOOKDZ1MnpO7b7PgZwEVjZeXS2h9EoWx5YZ0z/MWzY311oN/TZD56c0kGkbWPkwkQCA9diUBZ9CPEgJus276q360sT5FhCB0B8hOxH4adXYCIYF2DFzPAe3sTbVW7bGY3TiinZRiVUAxNUvW4E6HDkogNilG1fSLFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288058; c=relaxed/simple;
	bh=M/56l2HmHJs8ntjWEy8IAA2c0RZXAc/WeGFBe/GHxFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DybwDOyRG/Pm0WtR2kMv3QBtIlQO3o1w2kL4/FyywcO+ga0wC39aAAJjnuaty9qzuIUSabsM97u3/IrZcY+sKKGylEae4wADL24sbO9JJabaxZ6t2zpU/fVnQ+BbNYPT5zqTT1cxPOl/R0ZJ9vJZXdKKSqTPNwKDxvnlIb2eTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlvSuqKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlvSuqKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544A1F000E9;
	Wed, 29 Jul 2026 01:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785288056;
	bh=5IZ8WGUqH3pg5P7gSorB5hwy5YgA3JBJbP2h4pX7x4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AlvSuqKAdJr/6+OEBbjLYCMPXzBpQLD9rrCN0D0ZirWgJrNQ4IINZzaVdunq7B5uw
	 Ar+oWQi0+v37HHNpcd4J9mbxbFidCuQ41ZBVgXgmj0Luh/IzOeBmzgA/SQQ1zKcyyd
	 KdqQl6BcrgUdT6oF4Tvx+ai0nYxaCWITK3Dte8bXguwLuCnky1r8NuNbes3iv2E6fY
	 amlRMy36/Lwniy6s3aspN2I7s522LhRAQaJ3tC0877VQOnuhlCSXfNICjrMHwiI+rj
	 cj2exCtshzMsBEMtJ1ZuKL+rVKEMrh0Xj/sqyUt78If0kgCYXt/HZnkwqrFJXoDBmN
	 2s2IiUwPqg66g==
Date: Wed, 29 Jul 2026 09:20:44 +0800
From: Gao Xiang <xiang@kernel.org>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org,
	sargun@meta.com
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
Message-ID: <amlVbCzhf5V-pKA4@XiangdeMacBook-Pro.local>
Mail-Followup-To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org,
	sargun@meta.com
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
 <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
 <CAAwtZY6Bas3jLQZ_GDhbjj4pekjhT6kxAQ+5_35mzwk5_HUKhg@mail.gmail.com>
 <g2fx5drvoen4tkmnxe2mc44gihhtcwqhhvc7nbe4dbv6ay6idh@xc2zlk3s7q2g>
 <CAOQ4uxg7Mfk5Y1qV9YD1eifO-bJ3+miCm4-GLO=sBs9q-1mGNQ@mail.gmail.com>
 <CAAwtZY7T-x1ChoZ6vQQVFyON1wm-E-GR8Sy6qQyy6vEc51dejg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAwtZY7T-x1ChoZ6vQQVFyON1wm-E-GR8Sy6qQyy6vEc51dejg@mail.gmail.com>

Hi Ibrahim, all,

On Wed, Apr 22, 2026 at 09:54:37AM -0700, Ibrahim Jirdeh wrote:
> On Wed, Apr 22, 2026 at 4:18 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Apr 22, 2026 at 12:36 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 22-04-26 03:22:32, Ibrahim Jirdeh wrote:
> > > > On Mon, Apr 20, 2026 at 7:37 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > +const struct file_operations fanotify_control_fops = {
> > > > > > +     .show_fdinfo    = fanotify_show_fdinfo,
> > > > > > +     .release        = fanotify_release,
> > > > > > +     .unlocked_ioctl = fanotify_control_ioctl,
> > > > > > +     .llseek         = noop_llseek,
> > > > > > +};
> > > > > > +
> > > > > > +const struct file_operations fanotify_queue_fops = {
> > > > > > +     .poll           = fanotify_poll,
> > > > > > +     .read           = fanotify_read,
> > > > > > +     .write          = fanotify_write,
> > > > > > +     .release        = fanotify_queue_release,
> > > > > > +     .unlocked_ioctl = fanotify_ioctl,
> > > > > > +     .compat_ioctl   = compat_ptr_ioctl,
> > > > > > +     .llseek         = noop_llseek,
> > > > > > +};
> > > > >
> > > > > The new scheme with queue fd & control fd opens up an interesting new set
> > > > > of races which needs a deeper thought I think. As it is currently
> > > > > implemented for example if there's a task waiting for event on queue fd, it
> > > > > will never wake up if control fd is closed. Similar problem is there for
> > > > > fanotify_poll(). So we need to carefully define how operations on queue fd
> > > > > synchronize with operations on control fd and closing of it in particular.
> > > > > Besides dealing with the hung waits (which can be dealt with by just waking
> > > > > the notification_waitq from fanotify_release()) we also need to deal with
> > > > > fanotify_read() moving events from notification list to access list. I'm a
> > > > > bit unhappy with how ad hoc and fragile this looks but so far don't have an
> > > > > idea for a cleaner solution.
> > > > >
> > > >
> > > > I wanted to ask a few more questions here about the race conditions you are
> > > > outlining. Is it accurate that the main risk of races is primarily
> > > > related to early control fd shutdown with this new two fd case, or are
> > > > there other races to worry about?
> > >
> > > No, this is my main concern.
> > >
> > > > I added a few protections in this patch so far and wanted to check if
> > > > there are outsanding risks:
> > > > 1) Have queue fd also maintain a group reference as well
> > >
> > > Yes, this is good and takes care that the group is not freed. But it still
> > > can be fully cleaned up even if you hold a reference.
> > >
> > > > 2) Check for control fd close (group->shutdown) in fanotify_read. I will also
> > > > incorporate the wake up in fanotify_release you have suggested here.
> > >
> > > Yes, I've noticed that but that check is racy...
> > >
> > > > Regarding fanotify_read moving events from notification list to access list, do
> > > > we need to allow pending events in fanotify_restart_pending_events
> > > > after all to prevent potential hung waits stemming from race with shutdown?
> > >
> > > Thinking about this some more... Won't it be easier if the queue fd held a
> > > struct file reference of the control fd? That way the notification group
> > > couldn't be shut down until queue fd is also closed. That will deal with
> > > all the possible races, we don't even have to hold a notification group
> > > reference. I don't think this behavior would be surprising to userspace and
> > > I don't see any other possible downsides either. Amir, any opinion?
> > >
> >
> > hmm, that sounds pretty neat.
> >
> > queue_file->private_data = control_file;
> > control_file->private_data = group;
> >
> > Makes sense to me.
> >
> > Please remove the group->shutdown check in read and any other
> > safe race guards that were added.
> 
> Thanks, this should be much more straightforward. I will send over an updated
> version containing this change to hold file reference and other fixes soon.

Just a friendly ping: I wonder if this series is still working in progress?
Currently fanotify lacks of failover implementation, and our EROFS fanotify
lazy pulling needs this too.

Thanks,
Gao Xiang
