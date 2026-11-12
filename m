Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524565;
	b=DVxzlfp/kS+Zthy/PvNySi37Fo2j7X8ry9fHlJev+4FZ0WwxhC7JSpnRBApSJxpbU77H
	 uLA1a8Dk1rDR9Rh5HpyKv6WfyX994vmHXie08Vv2N9DFU+B9W5rmuZxYDZ1vLENM6acMD
	 5qJnnD46nngjQJ0zG3XHiWFITE86xKqz3GXxtcO1W7M3zFHNPHtbpAcBslMVdvn2pf/k0
	 TRW+5FniaAbdZgxBVWMvHkgDHmdfQlrIqIbvWRcAPNzwz64ugf2S/LtElEfxiFgUcGHOC
	 FaKEPYl239osqjyb+y6GobgOaBJrA8MB/VwelT80a3sijPyG9VjEkfMM5Nncl+k6FAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=UdI2gv0nE+PpiDHQRvxALGPPGMmK/uE84Q/kSWgFWc8=;
	b=vxti6CZiOSuIJbGD8+KsrePzyjFES5MfwxRuhMpSRxpGimvWo8/Vj0VtwNm7t3Iz+A3W
	 deLr3plZwVYmRkVAp+5W0Qvc0nulVT7AZ9MEsp5VGOSr0GU4mVlIhkhWMKHHCCzJ1NBcN
	 Gp7Hp4RWNruRdxVpqH/cIIovQpdmYk5X2mNptuFIyK3FmcNTUXQLCJf+XhU4U/TYksJHt
	 z4rHnE7vDAiWPB/koJpRyAP/LH4QXcCMWLAU1KPRJUUuH3+aPqjRc9kh96dpvYBbRYcAz
	 Ot7TWYhmf2R8DjqNi3J/LJWnAeOy/MSEtJeaNtA/QrzmQHUnhb+RJe1Zccg5bDam0uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=cl52A514;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E08606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 23:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E08606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=cl52A514
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so3200195e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794524563; x=1795129363; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UdI2gv0nE+PpiDHQRvxALGPPGMmK/uE84Q/kSWgFWc8=;
        b=cl52A514dZp9s/iyCKuRlFULJYoeu+l+XDeZgfaa8mqtOB/O2+RLH73XsImvRmlSmN
         HxhCuWFxKFmvtxF5R/ePkRzklwD51D1+ATvORMP+rU6PXjdu5XcOfenvXhLwY1vPvyTx
         uiy9856AXZJMF1iGSMGU6449sTXFav1K9/l7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524563; x=1795129363;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdI2gv0nE+PpiDHQRvxALGPPGMmK/uE84Q/kSWgFWc8=;
        b=hVnGDt+fPZk/0w9/0+0Vdv6RTkEmYu3fOSkBN0LjKhtiSwim+Ff5Mz0gi0cJHuDa3Z
         C7hn048ZejALSc6lD/nkqwTiP00pB7Vj5RJgKWph4tp9/QdPe0nNqd59pQmzw2ZecYnd
         unNLQC7i4Fu3Dsa71DUNKNIJ9gzBJdX4JgVzA7cdEpKFqzZ+wkiUoJov0a6aOiS53jpl
         pT3l+9DYTa5sZ/YHp71TocXgLwMKi2QzaIo7DTQUdQuU5sZDu8j0VOzQULHxaJnyBMPe
         Vqa+VGXIRG8QgZ6UuqLCB2ljdABn4MqpnMZJamMkgeDZnpqCfWfR1vrJNvilwa7kyUu3
         LqhQ==
X-Forwarded-Encrypted: i=1; AL+hErGLojRRfvJKlrezr4eRNRLo5aZiDaXftoClklQGqdvCW8xiz6+iBbc1CKtFlmevlXJA9ITmfcCQg+7k7fpl@vger.kernel.org
X-Gm-Message-State: APuU4Z8jfcl8oMsA+MTn8tblKF0BR4flP7NdL6f27zldtiTEf2BMOAEd
	m9jLkiqN5XlAPKUgB+kVvrfkmwVlJtLyUMx6hAHN7EuLq3uq2Mbume/pE96aBGOxzXc=
X-Gm-Gg: AYBFou0hrwA7XLJbWXLU1jcjTxcb/PtSqEWyR0aqz+rXtUPt2W7ZtNbrX8HrYDQY0mz
	QZ4MiXRLM6+S5uEzfNcx2WYqybBiEzYXMxbyFC7wYqs1i1cPjb1Xu+2ZG611SZzalqYvBr/m5zT
	vuBLJ4p1+u7x1OBwD52P8rAXemhpWh1P/CTgt7ncCcNuuX71C5m5lbiG1lVRMnNU9+6T4JeErOQ
	1jDv5MZK0AbAFsa6S8FR+SGduhwMczBEafBbdN/z3IKpShQ+4+QgslBwT+ZxJvO+o+cnSR266bw
	Duv+Q5zM1gGQnATB2VxMUd0rBgSeHXzTz0uiAYWVb6Mp+xR56wDcIKKHEQaIHS6MUODfMRI3fox
	JXGnll6tiOwS9z4/vn24/mtzjMR6q0XkDd70zMpsSiey3Ty+RnmhJWe7Knj+8AQseA9MJA83t5G
	vEnn1R2HAwh1gg8KCfbq4awfWOvHjL07O5n5EI3XUhboK7cbRrszAyr5TgDavjib9BHLx/Cq/d5
	Krwt/rximOwEuXyjS+e+53Zm11bkZC5iAoPw9lDSDacGA3DLxi3b0ZI9i3XbTi/gve05dL5Cd8U
	anuSuLACBqDRLJ1z5O9yiKKSRzQStCbtxxsePpdHeTN40ZRbEqoN2XsuGR70CKVqfgdq7IydBBR
	k+OcUYYM3bFt7D71ZDlpBLJuCDWFc1SxBkewVU9oTFon4FW3mtHFgvqXgrJnkfgcN1oTbzEE+Vc
	aav628712KBLXGAd9qqKkGMc84mbBeEIYGyzl3AhOXJ9si37INEVnvbNQLEA==
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr7941995e9.11.1794524563487;
        Thu, 12 Nov 2026 15:02:43 -0800 (PST)
Received: from [172.18.0.2] ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm816285e9.4.2026.11.12.15.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:02:42 -0800 (PST)
Date: Thu, 12 Nov 2026 15:02:23 -0800
From: Chris Down <chris@chrisdown.name>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kernfs: allocate inodes and dentry outside kernfs_rwsem
In-Reply-To: <20261111215058.1837351-1-shakeel.butt@linux.dev>
References: <20261111215058.1837351-1-shakeel.butt@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261112150223.f13e8b526933f9fd@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Shakeel,

Shakeel Butt writes:
>+	new = new_inode(sb);
>+	if (!new)
>+		return ERR_PTR(-ENOMEM);

Not a big deal, but one thing changed from v3 that the changelog doesn't
mention. Without an ilookup() first, every caller now needs the
preallocated inode even when one is already hashed. Before this patch
iget_locked() returned a hashed inode without allocating. So when
new_inode() fails, decoding a handle for a live node whose inode is
cached now fails with -ENOMEM, and a stale handle gets -ENOMEM instead of
-ESTALE. kernfs_iop_lookup() does the same for a node that already has an
inode.

 From a quick check I did with failslab limited to inode_cache and an fd
held open on a cgroup2 directory, open_by_handle_at() on its handle
succeeds without this patch and fails with ENOMEM with it.

Now, new_inode() only fails there for an OOM victim, or in a memcg whose
OOM killer is disabled or has nothing left to kill, and those tasks are
failing most other allocations too, so I don't think it's worth
complicating kernfs_get_inode_locked() for. But it is a second case
besides an inactive node where an ilookup() first changes the result.

Not a problem, just an observation, so feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
