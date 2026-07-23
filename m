Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B8384CCB
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789754; cv=pass; b=a34J8t1P2xDYf42vY1uQZ4EQbJ4LvraJMcGgkdkj9n+AdenijBRqGrSIdN4WI7J7pIImMzKs0Tk4RYF7uKZKDbzyIosEvS4RfjFb/1rT2FPsLwBiPf8CTk6JRtvbK/Ezy1U61uraU44k8/oAbT28XODUzLFrft8qsXu1rNBKcJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789754; c=relaxed/simple;
	bh=7xavlvPgaj2aZOYRfaOcUw2KPrv2zI3pLKx85cjIG00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exs1vR7fLrGKny8V+D8QLLtDaLagfIiP+XyeWjBu4eLPNketY8E1qeEKtxccoHDlUhaqbMYvCthN9TVjtSl/ZULQmLKAVKMHrSW41RTC4dhExqsXsBJMITiV69+/v/4hR5XGEGbbKkWxwpS7dcXNdbSjjar4oqG0QMAupCwy2v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kM6hJJwK; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kM6hJJwK"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0c68aa31so2349181cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 23:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784789751; cv=none;
        d=google.com; s=arc-20260327;
        b=W+MJ0mJrp8k+TkfGfLW8hmbhFWYWFcnIQklTz7YeEbiyYNn0Mz1zgU/F8xJ6cCioP+
         /g3LJm2K7OVQsG72Lziszfk3lXHuoPV/8hnRPTVMLjj++T1JIneu5K7tUlDwqGpqmhra
         MACb6p9VsB/6K2RRRYKi4Q9ySLhxL6ZK4H0X6mDCaJQnVjIolVep7ddVwnbJK6MXCX9E
         iArS3ZjHTynJzeCN5yJmttTKwS+SktBWROkJw6m6rM5LN2kZFG5c7YkMod4I/z/BWJo8
         u4WC72FuEvqYPTW2UJyrhommo+Ddmb9RbfRXJ7Nyk2bsw+EcbyjRclzPP/UH4PjjjJ7n
         yJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/L/US/G+XEKajQPS4lkAeBu5twJB/EgGo9GV13H6UZU=;
        fh=Yr2V1WNhF2aD0gbFUDz4zN1sasUHkh1K2tf8Ta61RZo=;
        b=Bon+k8vvK/0OoFB46SCqFpzCtl/s4Yr4+ZK8YCuO65FA3Eo/QSGmA9KuxrR8sZi1XS
         +h16Frfiy7GEvx21EBXOji0qGCjdecBwEiuQ6C/nvtMduifeyjWu6Ab0n+cLFaUZ5Dqh
         BAqNib6Alaiap6xhtTAgCw2vbeANWY0JubgQsfE+kJCRfLAJnXwmSHc5NLBmBjZw2qFH
         GOSpY6S+INmKlj1tg2FnoPtePI7uc/pN55kmPckPkF1NQTDFFhq8R5LWw/EPZAp0+fPh
         pRxbPMJWYOUolR5sWkn1yGHY1evKJ8iWFqoB9CN3EY/sl1SoatzWmbL20vf/ZZf/d6wd
         rl7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784789751; x=1785394551; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/L/US/G+XEKajQPS4lkAeBu5twJB/EgGo9GV13H6UZU=;
        b=kM6hJJwKfJqbN6hUs6EU1W3ElYn+UcXqPNu1Q6KVSbFegjsM69aZq8+QXN6D3y10ok
         qiLQMbszRUL9Earf5oY7MEgL7UpDRoX0yABx9vP8sUwsyKELbcJhjx9cGqdoGchOaVWJ
         1fxpmviavdF+wLskwjXaJf0RC52HQGiOf9m5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784789751; x=1785394551;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/L/US/G+XEKajQPS4lkAeBu5twJB/EgGo9GV13H6UZU=;
        b=ACVcZtGgwav6eZ0dOafUgsjXmqiSLp+dFV7PUk5RIfgGBQwPJaGVim4WUfsx/NeRNz
         QVam4kkYb84K9F6XlZ886i6/DZj0B0K3fMEz9C7Q5g1tXwSVRv8ZClNhh/A4xauYPvBK
         o9afRSasPKVDMm+IOjxK7zyunhUWSIF/BxlezDazTTso2WpmAvipqroHJKKDVScSwGFr
         Yf6IEIptekKp/+mIMcgChro5EVgitA+MWJbx+rR316noXA9I5UGh6tYaznClRi+Ig8QC
         BO4C+8Kda4rLLLLBqCR2kv9+7x64J4k7SyWCk6+q23kt1tO2QLECu6Aor5WLfWezprnl
         lpjg==
X-Forwarded-Encrypted: i=1; AHgh+RoJ5jnIFxqTSVfn9KuaS+aUuBX5X+PUVWsTQ8qT8wrHA0SNiz2/qkYS2joQQphhSogilvGikA8vJfUch1dg@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmF6djaRdtVVx6yBWtFxukPjNNjyZSwVNjrD3tFQXquOVGZ+J
	yC3WvYjdEVHiy0RD77tXG/6K+Pq6OlXD75N9Rnhy7kPdhIE+PWW9w92ZC0ouyAlGt+ddSPQArQ+
	s1b1h2FvnethmXgmi030Oxle8zEPUSOOArojUzpSIWA==
X-Gm-Gg: AR+sD12LjQv3hdeLgc5aw60lh+/dgBjIhnmIF8TQc/CQYPMDAu9uXEYMm/kb8H3GElc
	Pt8Awkm4B470E5G0KIvYIDc53XP+RTvjgalC7jGe3M3FRu4RLty7X4KPKYwL+EkCc8nloeIxThN
	wezWysSEa3RqnvSNuO2BGRmHQAEmdO8HthhtickMWrkHuAHZ10SZQScxIruqIn2ICyF6i1EFhno
	4Jpzf9we9Qc4LLQsTEYm3jcC0HI96KhxthGrL+3HUn/0zhKYY8VMihNwJpA0rY9s9iB5uCnpuM+
	VjibHhL7YuJzSn8m8R9vrVw2EmPzrXyVmvNMw2A=
X-Received: by 2002:a05:622a:2cd:b0:51c:7b12:5ff4 with SMTP id
 d75a77b69052e-5283dfea04bmr15949681cf.80.1784789750870; Wed, 22 Jul 2026
 23:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com> <amFMUtTB4SmHdYZx@groves.net>
In-Reply-To: <amFMUtTB4SmHdYZx@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jul 2026 08:55:39 +0200
X-Gm-Features: AUfX_mwm61XvzbEAWjZX7-oCx0aIcunUf-H5-PKtYcEgLU4ucKjhPy9XCcc8KUQ
Message-ID: <CAJfpegs81UPgqh3XsvAAE6PfDOiPcMceLZD7p9SRR+HaVZbgTg@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jul 2026 at 02:32, John Groves <John@groves.net> wrote:

> I will make this high-level comment: After reading Amir's initial reply, I
> concluded that the requested changes push famfs past the breaking point,
> and therefore the only way to keep famfs suitable for its intended usage is
> to pivot back to standalone. I do think that may be best all-around for fuse,
> famfs and Linux. I don't see any way famfs makes fuse better - it's a very
> specialized pattern that doesn't fit in a passthrough-filesystem or
> block-filesystem shaped hole. And I don't think it can comply with the
> "nothing famfs-specific in GET_FMAP" objective.

I can say with confidence that there is nothing famfs specific in
GET_FMAP that is actually being used.  There are some unused and
redundant fields in your struct that can be removed now, and we can
leave space for future extension in the extent format.  Adding code
for unused features makes little to no sense but can add significant
burden.  Allowing extensibility instead should be a much better
choice.

As Joanne mentioned, adding extent mapping to fuse would be a
generically useful feature.  It's been on my mental todo list for
10-15 years.  Sure, we can do that without famfs, so...

> If famfs is standalone, it can only ever affect customers who use it, and it
> cannot be used as a general purpose file system. When famfs is in fuse, it's
> mashed up with code for hundreds or thousands of other use cases. That's not
> a win from a risk management standpoint, and it doesn't make famfs better -
> certainly not in any way that would mitigate adding a lot of state /
> complexity / baggage to famfs.

The risk of standalone is abandonment.  That's a call for the VFS
maintainers, I'm not going to stand in the way.

Thanks,
Miklos
