Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E4550DB8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885673; cv=none; b=iOUBInipK0A9kjqxDIsjKXIbG6QOafdjTxBXhIZ7KKbthxgIoSaT+C22CoaZnY4RL0b8ejZjAxHd9VqfwYv1JZ5V09aFeqMeqL3T7DrrzvmRZsFHm/P/8KpzGJwVQvMsYGCE0wkc2b9CwOuchrDeEHHBo10JTBuONOwmarpaDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885673; c=relaxed/simple;
	bh=0WHkL3siKLt2gWr0nui1TBB7PxNZQd/Fg0sZRCV9eV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX5VMCJAf91xBES2w9ATvVnbOIvEdPsFW2GFXMXg/sYOfpCr6+pzmTEW5d2LS1QjFEj1+YZsqmgZ0kFsaSCXns3c2fDRQHVT0JtsLuu8OCmndzMJrnqxP1pGi0Plqv49AGFBhzKP96H82iJ7jegLZic0xJ/KP7fIH+6Eh7DIYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS8Q20EA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS8Q20EA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-485850cf499so3218049f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885669; x=1789490469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DmxATc8MnBJh9MLhFG8Zz8kz1UkODPqcBWsJlPPeeGU=;
        b=YS8Q20EAUz0y7tDRJmZpWJ0DrPQhA1ifZgh5fFQ2epcV09Z+I/WCHTz+VJj2aj6w2m
         UgnWTS7vmuSZfzF8Kx3jL61udLnCetn5/Mhy1tyVZlzQZrcA/v9JOxmoSmCtVSc7TWpV
         Pa8AgXwPnwu5BFwQ/k5RWPprYhT2HEpFLVTEDVPRJm5PhoA4i8DoENzuM/Q6G0QObjx9
         nGDvq+FQY00lsj9Q9/lO+le87fr4utWe6ZmiolioInn2UW0YOtqBC/B8nv4lkOLmiEbz
         lUfnbgjssuG4WWKHVpDgLz0xJshUmYpU3q8cuVAj8v/6CKba+bnRVy+el64hLgHjb6F8
         o2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885669; x=1789490469;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmxATc8MnBJh9MLhFG8Zz8kz1UkODPqcBWsJlPPeeGU=;
        b=P/BTpC27VYfS/f/1IGlPKqdiEmrUTqr1COBuQwfL1TGkByU2MBp8bu/jt6U9urA/tt
         BTsfDKNrQPzWb5YhvUwgQlDvV9FeIEuAZWJdvxRoq3FAodBMBwYhWFsLW0SqiZMSPWsQ
         Q8fghgLiLb9ckmac0asbdubq8//MLcHBmFYww1Fb7P1a4iDPzVPT5O1rufTHC1vfVzuU
         fWfSy0kkMHh+kuS3UpdWzqA1agsY1cTCGwmUGfj+B0SYgpLkZM10Cx5DuKSJDm1ap6EM
         BkwH3L4NOJuA9ATUicRiF01wbC5nugJigUgxx9FHeMZl4lr/qBSCIGGRXCshqgR5WVS9
         XBnw==
X-Forwarded-Encrypted: i=1; AKwUvBxU60emF5M35O4qfbWlgiiV4CK08EGeY07Z5Zh3quFr3i1OEbuv/x6bCEAiY2GrceEtXpAVR6vLXdBo//K7@vger.kernel.org
X-Gm-Message-State: AFuF++kcFvxmu++TxByvHGeiiTtvlc7WG1BmeNbfXgGLp/ZG+LKo1pn6
	xeR1beNxY4Q/NDNh5XRoVN7fkVyNeGg/nJSXXfdLV1Gkt2YfDGFh2+c=
X-Gm-Gg: AYBFou1RHCLLNQ/n2391mFORauymc1B6gBmr8tfDpWeDrFhCcTjzzbsGh6bluL7Uo40
	0deV+RXfRm5L2snpV1ZkrhvZQvTXo0b9jr+N+Bq+HmzKe3Le9KFqn3oKf4g0L5oNR2e2Ti+CS2y
	Rze0rBLjSHGXjpeHLV52qXcoQtxDPeLj9O8aBh6b1Qt+xDE1R0rTV+IoQTV/5DH+5BztrOZxX+K
	bZGmtN0hVFjCrGdDbhsGDBWNSoWJMatZjn5icUeDdNDLWH7n1o8W6ZVE7QgeIpn9uzWuQNUOQHW
	FCSz13ofc9mCw0B/Q/I7YETO6CAhLWyg1OudzFy3xOKE/U+bLQSyS3Y8iq16oE7Us5nUlpUi4Py
	Aoe7A8NlsADcuFQDEAwGx21y1nzjXz08joSKmeNVdKOQPsEW0FNgU8cTuRdQ7aaJa9/6OS1Grb7
	sHfbu39fc7lAwpPpuKxnYGZRhVQQ0E6R12EJrtDhhfa/56tpeq
X-Received: by 2002:a5d:584f:0:b0:485:a517:62a8 with SMTP id ffacd0b85a97d-485a5176dbbmr6928581f8f.24.1788885669413;
        Tue, 08 Sep 2026 09:41:09 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm25834639f8f.37.2026.09.08.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:08 -0700 (PDT)
Date: Tue, 8 Sep 2026 19:45:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Ye Liu <liuye@kylinos.cn>, Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <662ade9d-d662-4f6f-869f-08c41da53170@p183>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904083001.553587-7-ye.liu@linux.dev>

On Fri, Sep 04, 2026 at 04:29:58PM +0800, Ye Liu wrote:
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
>  
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rcu(p) {
>  			if (same_thread_group(task, p))
>  				continue;
>  
> @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  			}
>  			task_unlock(p);
>  		}
> -		rcu_read_unlock();
>  		mmdrop(mm);
>  	}
>  err_unlock:

What's going on here?
Now it's RCU unlock after mmdrop().

These scoped guards kind of suck unless you allow infinite line length.

	A
