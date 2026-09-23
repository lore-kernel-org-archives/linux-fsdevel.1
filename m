Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C994377567
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177413; cv=none; b=po6kBzLu3eocWQe7wNBL3WXWnnGGk9DX0s7jOwJ0FleRwCaHm/6aYNNzLiaBXG3Vd88tK1MT4mrkw+ViZZZUn8L3aQ77Y5iIxrqBQAwV/2JtdyITQdhA0lMmXJYzH8rL3W/HQaD6mu4EH3HMfTKfSmB+GJD94E+TJD0+w8xaH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177413; c=relaxed/simple;
	bh=hHT45KCVyU/LJc4vTwgUXz4ko6EKy1tobGtJBtbAvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlLoOOr0ukFZ8uGv2QxVRYlmrEFefQgNOq/MXyAkuQHj41lFrTSYxExgJivVGqSKDUcb2i7xbzSLKhsal9paJ9Jw+G1wwfXeAcH3hOsNcaU7uu1ZqoX+L9GTuzPgb0J/0pqsXv3bIqb5KWSQ/FJb+B0fEboj36kjFMmTXzSrtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6Jwqp26; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Jwqp26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790177403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpXu1UzbQxg6GBWiYDqEk5eUwt0ikMJcpmehHerlhA0=;
	b=b6Jwqp26DDEFWrWwOZYqX4wuawwpcyYXm65udsSt/V8ui5DMm8kl4iAnVqzlavWRW8Sy8Z
	TLuHOeisjRQvQXR9Xg2vKNd0wtn2Z0XoNPJ8FCPONv1gJnV9ajkipkmsUnqL8xlJDCE0lW
	9B8ePGmXXyq2y7tMJ8a9LmldlTMyKE8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-t5UbhWyvMfm6vBIFR7p4jA-1; Wed,
 23 Sep 2026 11:29:58 -0400
X-MC-Unique: t5UbhWyvMfm6vBIFR7p4jA-1
X-Mimecast-MFC-AGG-ID: t5UbhWyvMfm6vBIFR7p4jA_1790177396
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C71ED1978F7E;
	Wed, 23 Sep 2026 15:29:55 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1974976A;
	Wed, 23 Sep 2026 15:29:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 17:29:55 +0200 (CEST)
Date: Wed, 23 Sep 2026 17:29:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v4 13/18] coredump: factor out
 coredump_wait_inactive()
Message-ID: <arPwbwmQIj7SY51B@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-13-a5c1800dc930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-work-coredump-unlock-self-v4-13-a5c1800dc930@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 09/10, Christian Brauner wrote:
>
> Factor out a new coredump_wait_inactive() helper that
> COREDUMP_CLOSE_FILES can consume in a bit.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/coredump.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

