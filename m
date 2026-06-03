Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D237268A;
	Wed,  3 Jun 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482502; cv=none; b=m6Tur0oMPTIPrAaoj+j1X8eLm+SqHqd0s+vhKA1NCCY6dQB2Ni222ksk+c6jHnNmac0Yfbgi9faFyayGD4f9qNfWW7OMlS7wn/SWJTdk85z3CnC87+tvI7TlaoO9283wCvDJl/m8pHra/mfQGJm4PO7WvMUnrfTcM2z/bu+OV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482502; c=relaxed/simple;
	bh=ZGkuZVPZ9s9KfoIlJ7dEJd/+1dvizBkJNE0Cb3iTR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajEiwVnmkQh2yCEdIcjRTUfbIH2+bj+FuzqstkLmUXCInDa5suEqigpUeaTdn76jF5d8Q7cLRDEqq2nXUpHsrCH4tKzRpGzW+/5bYnghoIeb7uGylHkFpBz3k9iUYECYIY5/coHKiUwO3z3XFUiyFbSBDAoEblAj9Rua0QzQEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2Q1Dguo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2Q1Dguo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC101F00898;
	Wed,  3 Jun 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482500;
	bh=aL5mtFk9j4rQnSXBTtmj1YVIkPnWlaip8NOkI03jbOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n2Q1Dguopg8jS0PfkroCq0EuNVWQ81yx4WVALc089gQ2r8VJq00J/sdj8XU+zhkeA
	 /jtDDcIX8HSuxlQk3OZOpAXhUcOcrLmpC0w6cLhFMM1lrZfJ6ve/tptJrl2JrVHqzU
	 Im2/Bh0+E86+wRp9X5xGB5EkjPIt2wnSNMk7DtPn5dRESgM2NcVN6yAwSjrJKVXOjg
	 MFdEEHWnqxDXY04Eo4zjGcXM1K7mNnj4ZmQjaY0CByt07UhBSbjhNxThYnajGj0QmX
	 p2tcjuXkWG/PbtAQq/QT+aj5Vt6+6xOOR1i8Ucu5BHNBmb19UDqDWVrmMuKw0ABcXb
	 Hdv/ezgCcWjQQ==
Date: Wed, 3 Jun 2026 12:28:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
Message-ID: <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
 <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>

On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> On Wed, Jun 3, 2026 at 5:11 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> >
> > Sashiko said that pidfs_register_pid() can fail under memory pressure,
> > since it allocates memory using GFP_KERNEL without a way to pass in
> > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> > the event even when the group has an unlimited queue length.
> >
> > Should we make pidfs registration best-effort instead and still return
> > the allocated event if pidfs_register_pid() fails? But IMO this will
> > make the API semantically ambiguous. If the kernel guarantees that the
> > event pid is registered with pidfs when pidfd reporting is requested,
> > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
> > invisible within the reader's pid namespace. But if we allow best-effort
> > registration, the event may still carry a pinned struct pid, but pidfs
> > registration may have failed due to memory pressure. If userspace reads
> > the event after the task has been reaped, it still gets a FAN_NOPIDFD
> > or -ESRCH due to failed pidfs registration caused by memory pressure,
> > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > currently it seems we don't have a good way to register the pid with
> > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> > approach to handle this situation?
> 
> Thanks for noticing the oddity and explaining the options.
> 
> We could fail the event in case on ENOMEM because the system
> is likely is a bad shape anyway and other events are likely to fail
> allocation themselves, so I am not objecting to your patch as is,
> 
> but I am slightly leaning towards the semantically ambiguous API.

As usual, I think a semantically ambiguous api should be avoided.

> I don't think that we are going to change the man page to say that
> FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> add a NOTE about increased likelihood of getting a pidfd since kernel XXX
> and mention the known cases of pid namespace and ENOMEM.

The pid namespace shouldn't matter.
