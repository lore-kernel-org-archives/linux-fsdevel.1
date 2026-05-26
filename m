Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE2274670
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819742; cv=none; b=psomUG6X78eGebXBu0AjqHIpnWzfqOZ+XUYaaubGJTWxaptNRWWH791jalRiCrav9jBk9H5eiWMs1zIn5mJcLaa+o6i0Jq7iTP58cztdDBdK6Ku8T/Gj7UM17BvIXQ/JA7G3n/BIWUcNBZjBdMDU0JtpqGgTlnxprwv8PU4JuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819742; c=relaxed/simple;
	bh=zlYmaVIxdNX99KaTjy189VPXIUUas+kgW8ZjV6vlCA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFjpG9qwhsly5CHT0rUKUnIpg6/R9DyrTvmyY5FTXlDTOTa5HtZb1LrGCjM1wcuwNwB/GU4B8yd2Mj8SkHPCJdCnNgF7k7Ggp/vF4RB/UrNGceqXgDFb2mT5BhLTGeoyj3Cga4KS4XAxNqsKWLz8aheXj46rMpSypkXRZoLfyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agaLc0TQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agaLc0TQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779819739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnH0XvnakOmjvDsCffQvkdqlIl51HEj38q+ePa8HlEs=;
	b=agaLc0TQJ2yab8VQHxd3Sk0PAn4C3kmvrzp44VSzeghoLaQhVmPTnzYcCvdXYpl4vLhoql
	6dTbE2s2gAL9pHv0JHxdLWBHu5xeSYAWJLMJn2o7XovWGQJPdR6u87c630ukEGSbSqEQYR
	LeirlMvmni7BfT+HwmHeK8pu04diU8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-twMgr7NaN62BQVpyXwEEdA-1; Tue,
 26 May 2026 14:22:17 -0400
X-MC-Unique: twMgr7NaN62BQVpyXwEEdA-1
X-Mimecast-MFC-AGG-ID: twMgr7NaN62BQVpyXwEEdA_1779819735
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C5511956096;
	Tue, 26 May 2026 18:22:15 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A620E1955F19;
	Tue, 26 May 2026 18:22:11 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 May 2026 20:22:15 +0200 (CEST)
Date: Tue, 26 May 2026 20:22:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arjan van de Ven <arjan@linux.intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
Message-ID: <ahXk0lBmeewqINHh@redhat.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com>
 <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 05/26, Jann Horn wrote:
>
> On Tue, May 26, 2026 at 10:48 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > On 05/18, Jann Horn wrote:
> > >
> > > Fix the easy cases where procfs currently calls ptrace_may_access() without
> > > exec_update_lock protection, where the fix is to simply add the extra lock
> > > or use mm_access():
> >
> > I thought about this too, but I do not know if it is fine performance wise...
> >
> > And what about proc_coredump_filter_write() which doesn't use ptrace_may_access() ?
>
> Yeah, this series doesn't fix everything,

Aah... Of course, I understand. I wasn't clear. Sorry if it looked as
"you missed proc_coredump_filter_write" from my side.

What I actually tried to ask:

	- Do you think it makes sense to fix proc_coredump_filter_write()
	  as well?

	- If yes. Do you think we should add another down_read(exec_update_lock) +
	  ptrace_may_access() into proc_coredump_filter_write() ? Or perhaps we
	  should discuss other approaches (exec_id/seqcount/etc) from the very
	  beginning?

Oleg.

