Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95822068D
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554979; cv=none; b=LvQcyXF2Aexztp/K+5dbZ1cRzQIcb/JQRzBVot5hXZpguklx/TZMI3uKVRJqaQHZs2ZP5GlAVAOi3km5eTJh+BbeNkLk5QkMyP33ZUDzPhWppUgPn0BqBnhcVZypwRKlcxZtFy4bC1Is0LardMSAnK3v9/o9w8Sf8LThboJ8maU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554979; c=relaxed/simple;
	bh=tJOW8IbBfROkYsczfidt+hU/NZczo89lfIVKC2uVV8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im1n9caOjQDd/6gkHscvFIVr2yTENLmAn0OO9P4uOUWWstwepdGIh6xTsfW5ToJ6DW1FynQ0uGKdHG48HmTCBZq5PFTkEMOhqHAY6QXYsMHZ8gfvZhzPsXpRiXmZer5h6kUEbbYjXDdsv0MGTUPMsPCpff3W4zJNMa8MHk0b8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kshn5kL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kshn5kL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779554977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJOW8IbBfROkYsczfidt+hU/NZczo89lfIVKC2uVV8E=;
	b=Kshn5kL6flBKf3sqazi0jX6iYep9Ls5UCUSQkwbMWIFHf8jV74doLgPjMu2wB2h1BTS3J+
	7SXROBPs16mAcuGjCwBwp6xa0wxZv45ZcvnDf0X378OIrydSsu5A+dys2RNkCYDqS5UPoj
	ZFr1hPKVXLA3ZzRj10mHY1YfAKglL1U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-cA6n9uH2MduqzaiXzBY3Kg-1; Sat,
 23 May 2026 12:49:33 -0400
X-MC-Unique: cA6n9uH2MduqzaiXzBY3Kg-1
X-Mimecast-MFC-AGG-ID: cA6n9uH2MduqzaiXzBY3Kg_1779554971
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49D1019560B7;
	Sat, 23 May 2026 16:49:31 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1FDD1300019F;
	Sat, 23 May 2026 16:49:25 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 23 May 2026 18:49:30 +0200 (CEST)
Date: Sat, 23 May 2026 18:49:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
	jlayton@kernel.org, axboe@kernel.dk, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] selftests/pipe: add pipe_bench microbenchmark
Message-ID: <ahHalOM2Isn1vghq@redhat.com>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
 <20260522-fix_pipe-v2-2-a8b35a78244e@debian.org>
 <ahHZPLqAPXhobCQn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahHZPLqAPXhobCQn@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 05/23, Oleg Nesterov wrote:
>
> The more tests the better... but since it comes as 2/2, perhaps the changelog
> could mention the difference before/after 1/2 according to this test?

Ah, I didn't read 0/2, sorry for the noise ;)

Oleg.

