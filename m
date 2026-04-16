Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFB3DE44D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350655; cv=pass; b=YsNAKRSRUCXnMemD/O5ksPSW717dO5qfK0JecMhh5v38oUJ2tX5buqoSXoCxFA4p7g5K9lh3n3vO/aNu9ow3BDd75PdN0B13Yc6yqcu2cwnze6ShB032upKIumorXS95qXRYCNl3mFKzvFprRcgpPpZFWeeTyD14fHbCIxv8YO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350655; c=relaxed/simple;
	bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR1KAfXTpBGle87hjEZ587SpiAwMcFiALoAHOJFWqtRtJodJvwQI3G0NADAaD9SiIACEmAIiI0ZqbjRhDME1iO19OcO0Q0bJywUGdWpXruOU47uku0xxo7hkjsxfTCoLWPJ9tqdSI/8FibNP++AAb92lRHILVhEb/n+4nnwYYeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Vkz2Y8Xo; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Vkz2Y8Xo"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a6cf8242so61792311cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 07:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350651; cv=none;
        d=google.com; s=arc-20240605;
        b=g69vGSwj75h5yaC06etjESzOiJex4dZ8Z4ywDHBcqmtZEbVNMSNFHLxqMvjPAcIQnl
         fx5DcTz8eCh0m28ewzdnmPxIKadMpBReZdrjZ1SdH3ovYlJaK7mjXdKZ69mC2SZfoFDH
         rwpfU+uIWcUJX12YDLNalaKu4OgTAnDGv+yHQ/T5+Xotcj6d8X1NU+EMXgRQWNFD/LtR
         RZYFD5diJcHQ8jj2WetdqJq/JnpfdYanNAqoUe/FBeuoM2PcmTqm6GilkXfaA00B5bz5
         xPrNtjBQM98xa3K/InhxYeD5/N9EXKesG2eRNZRTA8OUzJpgSvgv/wjGTxpjhaXJe/nU
         +wUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
        fh=N20H3YlSWguwAwU0bsKw1UTsdQuacPqYHqd/ERNdW38=;
        b=XL1JKfcAF+sOw13Qno/ZjgslyMRbKXkElqX5D8ZcOx9C126LNEs4Jv2mS5MaXK80rh
         swEMsXAcZNluBBIAjBqs5/AEMsNLLSSgr/oRfkDKwTyGGKqk0t01L2413P1KklqFHlTG
         HU/XujV8PFE2uoXo6v79gC++/iyH8pnDvk0CmgG5egg+D7jHlaF4gfLaow6u8rsOB+k3
         F9IZ8f2L7cwToqxbXnQ+BD3LjCk/9gJA6d7T8T+BwL6qfvMA5K+PEK3yNh+Pjt3f5xtU
         K9tC7bKjLm96LhUZhCeN6w81t9QPr79qP5XNnuwSjSONNBadhyYs81CNq7wdoOzqUR2s
         Fcww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776350651; x=1776955451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
        b=Vkz2Y8Xoeai4nTDEXzYoHRpchx5F3hj9pq+TKfqVd/COauwMzp+tiQOLJOFzAYR8P5
         OkB3diwv809cIAByqX9BnduaMgkTGjc8D4BTHSFgjWj5LnKfy0i8txFpBaokadZ84N86
         3Cs1m0pvsmywvRwuL5mZTjaqEq45nYpApVkQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350651; x=1776955451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY+xFfoVCtzNy2f7dBFh2baIj1I8x1776kXCRcjjm3U=;
        b=PIGwom7H3YmeOrR2y/PWYAYTRXjnnRuzGSQf/g82Ba8ITKmItEJOk75aMNulyTniMp
         3C9ER46aFCkC/bE5U+VDWuvqFOdW8NNl9J5FqK5rKQ49y0VqW+9UDNTEnh8K+K4snddX
         5iTIYy4nWOXpcm8EXqDFsiVi5IyuhLOL4zQuQdvcHe3RKiA0SNOxzTVGx2WITG+z8ZCb
         4HGg5U9fDhJiyMRCjZXHhK+r3HD+pY6isvE9HLm8xcm/MkYRSAlU+eAYBxnrUF1HxIG/
         237lhitvxeaYlwoZvPdPMBS7jAPdH0roS+2vspXRs7Ni+iLi14Gw0hedr+/A4gddlUye
         w7OA==
X-Forwarded-Encrypted: i=1; AFNElJ/Z1c9SwkKwMkcQapEmsQp+AU3ygy/9D/Boe/qoXfKCCmLFgajczy5HrcdJ5rsaRyeSz0KMrFfZPEbhTxjD@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPVA+mNMqVFkIKOB4vdiiksuj4JTB3yXHM5kw0oI1GNuoRXdS
	6TkBZ+0z5pYdBTMeG58Qu2rabxK1g+7/wlQy7B4Hx25BLaIp7JjGSmREeTEZLsmpG+zvjtIfQv5
	GbXIm7BvBh1FJ/rs1n+s9uyOiCjDGwtV1/RB+6JYbeqyhA/SKbasWkiY=
X-Gm-Gg: AeBDieurTOJOB6kbo4g/CCNti9nTotgOIw8sUmOusYg69SSpqzxngNisv7mwbAF+rvp
	cFjTU09rKVc4eCbF1QenKHal84nTAsXpI+vzgoEd/Gu1AO9QHWrrUY1Tg0mJ+m1mrJRR0mtz//s
	dsr43qWfGZPywKJK4T/jirGrqHicaaIDljiIX4+OC2yLquOmvJ33O2/YQdwI0W7oDmO6HjTRh/H
	U+IvuCaECs56JblNyz9QxGZz4TdT3hfSU9Tb/tyt5ai6ul4ZZJpBUMP1EA2b96+RjQizLbTUHiO
	7VoMEXvhX+nHx4+qrr0IN2os7KaaUV5ubcqn
X-Received: by 2002:a05:622a:2519:b0:50e:2b1e:9d14 with SMTP id
 d75a77b69052e-50e2b1eb0d4mr28274851cf.29.1776350651371; Thu, 16 Apr 2026
 07:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408172510.52950-1-joannelkoong@gmail.com>
In-Reply-To: <20260408172510.52950-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 16:43:59 +0200
X-Gm-Features: AQROBzAJ6jKrtMdHiBfUtDdqaZH4zd4thBXdfD61RInP-ruugcy9ZnnLnkVHGHI
Message-ID: <CAJfpegungbDJ57MJnLACuzKEqCDOBgPH0WzZ+9Pt3FJHDaCBGQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix io-uring background queue dispatch on
 request completion
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, hbirthelmer@ddn.com, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 19:28, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a background request completes via the io_uring path, the
> background queue gets flushed to dispatch pending background requests,
> but this is done before the connection-level background counters
> (fc->num_background, fc->active_background) are properly accounted,
> which may reduce effective queue depth to one.
>
> The connection-level counters are decremented in fuse_request_end(), but
> flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
> the io_uring per-queue bg one, which means pending uring background
> requests on the queue are never dispatched in this path.
>
> Fix this by accounting the connection-level background counters first
> before flushing the queue's background queue. Since
> fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
> skip the background cleanup branch entirely, which avoids any
> double-decrements; it will call the wake_up(&req->waitq) branch but this
> is effectively a no-op as background requests have no waiters on
> req->waitq.

Does this guarantee progress if there are still requests on
fc->bg_queue at the point when ring becomes ready?

Seems so, because there must be at least one background request on the
regular request queues if bg_queue is non-empty, and when that is
finished, a new one will be put on the pending queue, and so on until
bg_queue becomes empty.

Maybe add a comment about this subtlety?

Thanks,
Miklos
