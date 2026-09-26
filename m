Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712863AB288
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790423585; cv=none; b=q6JGEveX6ayFbNGRA0nGIhkgOUSmacz5rvhyQqfc4Hd7wdr5QfiOhpbR/STPDJavS2PopEmpLT5CTV12rP6a8/eyHUY60nTtt5/kDJk7NfnAZDZsiicSSPDUuzqL7QuOSbICPP05O4WnxpD2hgRbUIWQZ1wcR6L1tKgPG+6FPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790423585; c=relaxed/simple;
	bh=4tdcKx/89P7WVVGaM6HG/qI5HPo1vELarZ3vWaCHzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeU3Wi/cUb/3/6voBlFFmkMoYd0JVkqY0++Hkaww/VXSKcMWzIiN0/hmcL7uqBXhmILpeLm7kCmsm54Vcb9W2hoiig65IyLE8QzUiu2Td5TjK1N5CCEewXPoEWzTvAEkGsSxxUa1j5mudhLFbutu5aDkdlhRrSn4ASte5dJhSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyArn0e6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyArn0e6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790423581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4tdcKx/89P7WVVGaM6HG/qI5HPo1vELarZ3vWaCHzBU=;
	b=hyArn0e6JXTgu2pDxzpbilS9q6MkU1jaxngjJJVyyrBShGOJVgDgFRinERjYgfwLtucNGc
	Mx6LcOw1BWjDNzWgA1E7F56cOyx1lkLvmssSZl+U4PH+9RqMGxLS4V8Ihzxcz5t4IJw+vA
	J+A8/Nwh0tLdUDI1VC3Rm0jtdmr67XI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-1Ss9ReOiN_u_Nd-_52VokQ-1; Sat,
 26 Sep 2026 07:52:58 -0400
X-MC-Unique: 1Ss9ReOiN_u_Nd-_52VokQ-1
X-Mimecast-MFC-AGG-ID: 1Ss9ReOiN_u_Nd-_52VokQ_1790423576
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BE961954201;
	Sat, 26 Sep 2026 11:52:56 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1BE5A41B;
	Sat, 26 Sep 2026 11:52:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 26 Sep 2026 13:52:55 +0200 (CEST)
Date: Sat, 26 Sep 2026 13:52:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v4 15/18] coredump: add COREDUMP_CLOSE_FILES
Message-ID: <areyEy7TkYFYHE7_@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-15-a5c1800dc930@kernel.org>
 <arU4EfGVonMKgzrb@redhat.com>
 <20260925-kundgeben-kopfnicken-katapultieren-85e8f57ef815@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-kundgeben-kopfnicken-katapultieren-85e8f57ef815@brauner>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 09/25, Christian Brauner wrote:
>
> On Thu, Sep 24, 2026 at 04:47:45PM +0200, Oleg Nesterov wrote:
> >
> > I don't understand this smp_store_release() and smp_load_acquire() in
> > coredump_task_exit().
> >
> > Both wake_up_process() and set_current_state() have the necessary barriers,
> > see the comment above set_current_state(). So it seems that we can use the
> > plain store/load.
>
> Oh, I wasn't clear on that.
>
> > But what I really can't understand is why coredump_close_files() can't just
> > do switch_files_struct() itself. It could do override_creds(ct->task->cred)
> > if this is one of the reasons.
>
> It can, it just felt cleaner to let the individual tasks do it. But I
> have deferred that part of the patch series until we got the synchronous
> close in.

OK, we can return to this later.

As I said, the patch looks correct to me, so FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

