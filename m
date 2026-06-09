Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8953F928B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996739; cv=none; b=S9Q7UHcoqKC1le6Yy2qGw/+PZW72uO78iXzgPSnx7LD+fE9kySMnYW1XynXsd6LO1g7UuyUXrywaPh2ccw534oWd6EXq9vEL14AJ4jWINaTuY+ouIPTnjUn13kKULzXkPHTX3Cm2H0SmXVY/yHT2B0QfOAvNun9tEbx/ez2BWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996739; c=relaxed/simple;
	bh=SSGs7AlR+Dsa6LU7DjLHzsIy+mmezxo8Y7lCuLQL21M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzQkjxlPUH75gHqWqnorPytyVXrCwTsDFRzeKXLaFIjUYW7wiKMivmSaC1otlAad/PTbLsj0Dquz8FlmyBaB8nHXOo5tkxchLN8sWPPn6kzrzG7S64aV88q5K5IZeRY7jUFYGys/lvlZmnLfcpnPJ6u2UDwz1YMsMRTtY6Zlg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeAlY4py; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeAlY4py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780996736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0RyvSuCfl6/Kma8+mEak3dnmweNGbwRU5Exj9W/T4A=;
	b=TeAlY4pynr7DUzmzNxvBojlBceQG4cegs5g/GCcjv12CZE5tsORN6PWyTNW1iYrfC3ULC9
	Z+gJu5zX1soqPat407hR4UTFE/JEfV9Pgz5hZW59u3Xh89EE52vLX6TMiqUZudFfBBubOk
	/HFb1of49afJ8ZvW6tn3jMW2BxDXrok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-2OOT0C1bOhuJJmTrhMN_vg-1; Tue,
 09 Jun 2026 05:18:55 -0400
X-MC-Unique: 2OOT0C1bOhuJJmTrhMN_vg-1
X-Mimecast-MFC-AGG-ID: 2OOT0C1bOhuJJmTrhMN_vg_1780996734
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9149418005A2;
	Tue,  9 Jun 2026 09:18:53 +0000 (UTC)
Received: from fedora (unknown [10.44.48.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2E04C3008B36;
	Tue,  9 Jun 2026 09:18:49 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jun 2026 11:18:53 +0200 (CEST)
Date: Tue, 9 Jun 2026 11:18:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 6/7] afs: Remove erroneous seq |= 1 in volume lookup loop
Message-ID: <aifaeKvz3KemfzaS@redhat.com>
References: <20260609081738.770127-1-dhowells@redhat.com>
 <20260609081738.770127-7-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609081738.770127-7-dhowells@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/09, David Howells wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The `seq |= 1` operation in the volume lookup loop is incorrect because:
> seq is already incremented at start, making it odd in next iteration
> which triggers lock, but The `|= 1` operation causes seq to be even
> and unintended lockless operation
>
> Remove this erroneous operation to maintain proper lock sequencing.
>
> Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the call processor")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/callback.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/afs/callback.c b/fs/afs/callback.c
> index 894d2bad6b6c..833ac3178ddc 100644
> --- a/fs/afs/callback.c
> +++ b/fs/afs/callback.c
> @@ -140,7 +140,6 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
>  			break;
>  		if (!need_seqretry(&cell->volume_lock, seq))
>  			break;
> -		seq |= 1; /* Want a lock next time */

Yes, but now that we have scoped_seqlock_read() we can make another change
on top of this fix. afs_lookup_volume_rcu() can just do

	static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
							afs_volid_t vid)
	{
		struct afs_volume *volume = NULL;
		struct rb_node *p;

		scoped_seqlock_read (&cell->volume_lock, ss_lock) {
			/* Unfortunately, rbtree walking doesn't give reliable results
			 * under just the RCU read lock, so we have to check for
			 * changes.
			 */
			p = rcu_dereference_raw(cell->volumes.rb_node);
			while (p) {
				volume = rb_entry(p, struct afs_volume, cell_node);

				if (volume->vid < vid)
					p = rcu_dereference_raw(p->rb_left);
				else if (volume->vid > vid)
					p = rcu_dereference_raw(p->rb_right);
				else
					break;
				volume = NULL;
			}

			if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
				break;
		}

		return volume;
	}

Oleg.

