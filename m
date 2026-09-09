Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B357EDA6
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970325; cv=none; b=rh4EtQcPbZJkhdjQvv7mg7vcN2vKgfnjbe0derQn/3ywqEusvapnkxhwM2tmMd+EaaSw7dEY2/53rw+JghHL1gBEf0t866EmCDBSv6FwnmrB8zhnHX1b953iy6zFoWvm+4CqxuunqVZg+Vr/+l/ST+pGG19eD86l/3B/5qGzgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970325; c=relaxed/simple;
	bh=hiRBQugCjUC2qSlftimk1/dBleMnW9pQ7uDf9NI+8s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/gZ03tkTiRmyry+qztS+YVR16rzCwRMh2pLLNoIF1CUgK5vcWlr3WKXrMCqse7YeIkN2BwRWYZojbk3Hs80cBiqvhr4eQKDaAB8uJcd4zoFpaFCy1mxOgfwonkNoeDv+xcPlUhWQeHNFtH7SQNSovvpR+FSI61rf0+TE0hRq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TObYY2yG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBfbE+tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TObYY2yG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBfbE+tc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788970322;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJ6zoCiMWbIIPldwdYsAIIdGbzVoK/NeTnUzI9OwSjE=;
	b=TObYY2yGK/6+T22uydLYVc3XMPKFbxIKgpMQTbFL+PhHVdKx03Ygcn98+HtYnlqFMEWQW5
	MyJ5DmfjpPedHW2e+eg3PU4pwfUU5Bx/6OVKJKqdWDlcEOqYzgpegnXsQJ6yhSUQRI96zZ
	DElpKCuv9vM1MtOERYC07s2ExuFTU1Y=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-WajjxBVHNPi2Ot150MP_jw-1; Wed, 09 Sep 2026 12:12:01 -0400
X-MC-Unique: WajjxBVHNPi2Ot150MP_jw-1
X-Mimecast-MFC-AGG-ID: WajjxBVHNPi2Ot150MP_jw_1788970321
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-86c3a053d9bso81594437b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788970321; x=1789575121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AJ6zoCiMWbIIPldwdYsAIIdGbzVoK/NeTnUzI9OwSjE=;
        b=UBfbE+tcXDFma8uUtlLsbfOLDREqMtuDVfC9Zlx6Q2Khgsfu4mJwLpYv8wgSr+J5Dy
         hNnN2shk55HbUrGkmvYAn7tC2rVpZrVh+tqnFMMtikM3FIyx8Rpw0fjoRUSmrz8KqxdC
         QIGu4XLplRKtclYrwHN6QdOGX0g/xyStPYRDBBRB8vM0BQiZR1kzbsvylp7awIH6eFhS
         gHwoo3HMzXoewMp6ppm75iKR9X0VeXcbef0NYupZSzgnOv+4sr99JkWrJ3IqeKW0ZZK/
         Mf9fdhGVKZAMXH1zBWQi18qDYjgPT98KVnA9o3jguGS7ju5srzO/P8onmW1/pXQSOjul
         TvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970321; x=1789575121;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AJ6zoCiMWbIIPldwdYsAIIdGbzVoK/NeTnUzI9OwSjE=;
        b=RWfi5CYjKtCnyhcqVBicBfXHTxAoPVAYtXHJ8lflD043klHyg0Ptl7E7aD6mfD1B90
         cJIXKqm/02zVFMtWvUuIU2zXUogCPHcPpAwYCF5VUEFBwGWTuIOtqWSdTPpPlt07i5Mh
         mvQ+6GiSK4XNkwx6sP4vbyj942HhZJ0xGLTTiKuVwkVcHMb+XPOGtv/DF6i3+X0JtHl4
         Deg5uAiV3s3/e8vqf6pmWvgjQdRohniqrimCHugrQ1bOukm9e7S2YomeL6Z22HqglwqM
         IdFY2Mvo/OpxBXpwZvUfda9bupNAedzH5P4FU7ffbzECCq+M2RBAcR1/CJWpDx7WBK8y
         S9Gg==
X-Forwarded-Encrypted: i=1; AKwUvBxmBE3uXYxCKnXLVgZ9V6GQLnuL5HVph/dbKAF8j0nODusoF0GEYK3EkeRzM3IljbBbqQxjkpbjU4c+BuLy@vger.kernel.org
X-Gm-Message-State: AFuF++kkdhY0FCryfO9HvpTNKqFW4EVnRJG+hdvhyfc5aC2XngYeYe34
	A+N1OhQBnN1HnzPXk0abum4K6kLTttnZInF4FSq5yFvOtyEOJliE78h+2IPlstVs2+VSVsGcAxy
	DaZ0jkgqQqLNyLF5atvlTduUwcgG2HiFAuFoXHTAvlYKRV61SModQOa7O0YYxivATs+c=
X-Gm-Gg: AYBFou0O6UjzQ9C5cBssFRbbOLhgfoacnqvm+B5SPoM5kOavXOPRPWLWMCKwiMEraGs
	L7ks2brapxHIIs0jjgWihmyH0pKKlW1iuaaxWUdWVMJr4i9v74bUO2cV2JCUO85qWT8MCw8T5mV
	G6KLnKfDPgct4TfxmeK7PfiOKRJcGEA1odtgjjF59XudAIFGGof2HF0BLRHGCpA9uq+TxTgo9yV
	9IGSPmIQPHh40+YS4y3memJZW9LC0sJIh1Cor7WmtB8WHfHXE9Pt0zUOR6+kbv6oBkyAs6V8G2l
	sbiNMFxrtrbne6kYF/LrfFktJEdkyhzgGtBNtdt8cBuB8D2XwkaRw6J3v3dLcTqpaf2VhrIiHo8
	56sdFbdUw5EUIEyINOK4eAPVYeZRikEcd3Hx89IfI
X-Received: by 2002:a05:690e:bc4:b0:664:c3aa:66f0 with SMTP id 956f58d0204a3-6710371652emr2217068d50.39.1788970318481;
        Wed, 09 Sep 2026 09:11:58 -0700 (PDT)
X-Received: by 2002:a05:690e:bc4:b0:664:c3aa:66f0 with SMTP id 956f58d0204a3-6710371652emr2217055d50.39.1788970318005;
        Wed, 09 Sep 2026 09:11:58 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm12713671d50.2.2026.09.09.09.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 09:11:57 -0700 (PDT)
Message-ID: <afd68097-b2b2-47e5-889b-fb077e7a9247@redhat.com>
Date: Wed, 9 Sep 2026 11:11:56 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: netfs_read_gaps(): aliased sink folio makes the read destination
 unreadable, SIGBUS on cifs with signing
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 CIFS <linux-cifs@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com>
 <1714046.1788952509@warthog.procyon.org.uk>
Content-Language: en-US
From: Frank Sorenson <sorenson@redhat.com>
In-Reply-To: <1714046.1788952509@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/9/26 6:15 AM, David Howells wrote:
> Hi Frank,
>
> Can you try this?  It can be triggered manually with something like:
>
>     xfs_io -c "w 100 100" -c "r 0 4096" /xfstest.test/foo

Hi David,

With the patch, generic/759 now runs to successful completion on cifs mounted
with 'sign'.

Two things, though:

1) IIUC, folio_alloc() returns an unlocked folio holding a single reference, so:

         if (sink_to >= 0)
                 for (; sink_from <= sink_to; sink_from++)
                         folio_unlock(bvec_folio(&bvec[sink_from]));

unlocks something that was never locked, and never drops the reference.

So should these be folio_put() instead?

With CONFIG_DEBUG_VM=y, I think that's a
VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio) on the first gap
read with a non-empty dirty region.  My test VM has it off, which is
why I got a clean pass; but with bpftrace, I see 190 leaked order-0
sink folios (760 KiB) over one generic/759 run.

2) if netfs_alloc_request() fails, the kfree(bvec) at alloc_error is reachable
before bvec is assigned, so I think we need to initialize it to NULL at
declaration.  (It uses mempool->alloc() directly for the read origins rather than
mempool_alloc(), so it can genuinely return -ENOMEM.):

        struct bio_vec *bvec = NULL;



With s/folio_unlock/folio_put/ and initializing bvec to NULL:

Tested-by: Frank Sorenson <sorenson@redhat.com>

(but I'll retest without those additions if I'm mistaken... it's happened before)

(as an aside, 'git log -S' on the bvec_set_folio(..., sink, ...) line puts
the aliasing earlier than the read rewrite -- should the Fixes: be
7f84a7b9892d ("netfs: Make netfs_read_folio() handle streaming-write
pages") instead?

Frank

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

