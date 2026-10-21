Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612483;
	b=CJymVDmpychezAZeNUS160mtlXIRulUPvzsOT5RgMsrRhUIYFY6g7IY2O7w4hVPE9k97
	 7Bjvogo8tTkp7TgKzlrInr8tlawRkYmOakSRYs22egMDYPErqleUWdCTh+81IMgJi6soI
	 7Z1g6ksQoCE8N3PUUIY9GP81Cv8bk9RbgJKPy8scvIQi46O06rS46nspVUldaX5dgXHdu
	 2tOCg+n5dkZQUB+9I+l9823G/Oc2IyYI4m0WjwnL0bwYrZcH3ONJnVgyaF8eviDoNDMas
	 Kgc5HH8VwZ6Mb+eaO5ve6PZOh3oOU5TVUiLyf6C3YJxsuRxMgDyxYy8+3cV0p7CGTSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=p3XlkS0/fbGXIcy8WFlJhVYpe1sgISTA20pUdhYo1to=;
	b=4XDgdGyiJkI7kBeUGfCNw/iixjsJrz/GBof8eX90NWpewhxaLEk/BU59N/3c006nDfLC
	 tap28wmrg4zHNhuWeGZGihD3XJV6Cp7Fy2QcET74UXhySSXOayFq+DaaKQsmrd7DnTtu+
	 c2EdkQdavmI0L6y889sbagJ4j4Otm0BOiKfLH9vgFmy56xh3EeO802PlhXQYnq+fNd2Jl
	 tOQtQPIu1LJYc9ehKsNORnv9zXybZ+vl04j2D9Ask8HlyS+s6S//mea/H1eJ8InsjRQmX
	 dY1LYqfu1Rhtm9oo6WvwBQm+6nObkClE6GeVTIQbQv1FGOD/XOo5W7UFA7urA1PgWCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="Ot/PRGVR";
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD1606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 19:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DD1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Ot/PRGVR
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-677dbe051d4so966083d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1792612482; x=1793217282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p3XlkS0/fbGXIcy8WFlJhVYpe1sgISTA20pUdhYo1to=;
        b=Ot/PRGVRmvnQQKyCw0ja8DeSkNSwxZyYMh4WDwCmOkFTm4cKX8sQxnq949iW9Vw5Ae
         wpCUD7VuxFLWCANhkX3rxduUy/i/Leq7ABSSh9D/ITwBmjLJwRJF5dG20v8gK+Oekq88
         xMJO54PiNND52dMO89ahfL/wmJvLhhOTcluTOGVJNBLhpw79rjPC3BXBIpBm58cXau9n
         bh239MPh24ZYundKEGuRgRAYzc0rx+h2f2eiFKpQiAOJ7Q6KkLpAQwKrGVBVJO/PCRFx
         5hintytlQmvvhIp9/cHhX0WIsEcEWGP+RtpRNGacTEemE0KOGINKx4cq+flEAiTS1wA5
         2zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792612482; x=1793217282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3XlkS0/fbGXIcy8WFlJhVYpe1sgISTA20pUdhYo1to=;
        b=nh5aLS8wUp44Vkys6aN1cUSMKa2UQg3kQGc4cRrk5SAND5/D/Q0wdYKhqg3Wt3jYTT
         Nq7E/Z9x3UbTnUuweD60Vv/NTAZOzh3QGmU3bFrDMmS8+7BBxGrw8sBcwAgdKxAdLv9t
         E5+SsRDNl2kG2XuJ04o8hNlIdO2tpyyaq4ULwBJKAQ7nGpKsrhRmedV20aaGeMT38QAJ
         9xzJQzJAsBw1u/PG7oyBHCJ2eaQrKTx2CjSdrG+Ch1iVzuD/V+bmKzldrVm+gMGhWwMC
         U4MCmT9r6VDUb/YsF9VoPBPmkNrLPHnSWVJYvhnbOrREo7di+DNMCnUtIjkZ+UCiDkD+
         OKYA==
X-Forwarded-Encrypted: i=1; AKwUvByYEYkzw+o/Nm6LlDXpKKRnf2//X0IxMtRzTIu0vPIRXbm8uQUnideIL5zAZO90mNVGNydpg8nffX14rZRi@vger.kernel.org
X-Gm-Message-State: AFq9FYJFQwjpnHUUfKcc+Kh2Fua1pQfU4Z9no2BRGgSBGvhkx9s/Svu6
	ybxnzMfo1BEO1WKc614fFrai2uRbnp66zKhZaNVotEDASRCF7tya7qepM8xKtwodIIsOS4S4/8w
	4RzKrlg==
X-Gm-Gg: AYBFou322Rz2F9aUU6pxcygovPfBcT9jdbYG/cfcFmtx7w2DdUhjs/Gok7V5XnUM4Bu
	ShlFYAA2PS8ZcaZ1AtP2oSeQ1s6XoA/kJxLfhZNdJ9oR/kM1G0ratGQSP8QVs7jGKjh7ici+DbX
	huuESYcWX+pIVy5DiwKIiKip44mERUU7pjL/UTcFB7ToaEuOM3e3w/gPg0n8Pgsx5xybB93gba0
	19ObgDLYxrqUfFgocSxTqLT2sdSGNeZSTxmMteH+u85Rq5bowEVhgXpiP5Bi/hQGIiKtXtVHcGC
	N2hNkA5w6sOublI2vlLyz7eMXK2qUYNT9AhFtZoUxmU/+1y4OoF0YZIRDfAk4re6JJr3zZxRFMj
	w/Hqe6MA0IKPfgV1TIrrc5BVi+NIYmR9NhQkyp5rJyHCpdY2yym+h/CdkeaPFOAQm3Uz9XiYSGW
	17cq+WnH5n8L5n/U7t+t4szaJ2/AS8xmfCNH8an+gWD2Vw477lmqS5L6PJoV1b5a2cCfkW3t4dh
	k0j7bMwjbQf8tv52NOmGS9JFBSoVqPXca82BfamDSoyuWVaSAyJrcOYBHY9d9wYh2NGOwUBdQbX
	7TAmffv9pNkdBPtxe/ZAdqu8
X-Received: by 2002:a05:690c:ec7:b0:8a8:6fac:217d with SMTP id 00721157ae682-8b1340ce1demr17081757b3.95.1792612482202;
        Wed, 21 Oct 2026 12:54:42 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300734dasm16443067b3.12.2026.10.21.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 12:54:41 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:54:38 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] cells: a container as one kernel object
Message-ID: <atkV5pSBmZbLH_i-@toolbx>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>

On Mon, Oct 19, 2026 at 04:50:47PM +0000, Josef Bacik wrote:

(...)

> The system calls
> ================
> 
> They are split by what they do, as the mount API is, so that "may look but not touch"
> is a system call number: ``cell_info()`` changes nothing.
> 
> .. code-block:: c
> 
>    int cell_create(int parent, unsigned int flags);
>    int cell_configure(int cfd, unsigned int cmd, const char *key,
>                       const void *value, int aux);
>    int cell_info(int cfd, struct cell_info *info, size_t size,
>                  unsigned int flags);
>    int cell_open(int cfd, unsigned int what, const char *key, const void *arg,
>                  unsigned int flags);
>    int task_configure(int pidfd, unsigned int cmd, const char *key,
>                       const void *value, int aux);
> 
> ``cell_create()``
>   makes a new, empty cell and returns a cellfd, which is always close-on-exec.
>   ``parent`` is ``CELL_SELF``.  It takes no privilege, but it makes a user namespace,
>   and what applies to those applies here: ``user.max_user_namespaces``, the LSM hook,
>   and no chrooted caller.

One thing to consider here is how we want ucounts to be handled. I've
been burned by those in the past, since if your container builder runs
as root the ucount accounting rolls up the counts to the user in the
initial user namespace who builds the container.

e.g. it's easy for a bad inotify container to exhaust real root's inotify
limits with ucounts if the builder itself isn't running as a unique
user. We ended up making the user namespace as the container's kuid
in containerd to deal with that, but with the "no provided uids"
approach you don't have that option from the builder's point of view.

Might be nice to kill the ucount rollup at the initial cell that was
created... can't decide how to deal with that all offhand, I'm sure just
stopping it there has its own issues.

Thanks,
Andrew
