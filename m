Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502794;
	b=uEv1FJHBb0rJm9ifsJ5iIfsrc1t8CRpG5Hwxhw7Me8pTv18V/GV7PZnHg2P4FESTE150
	 9VReeuHANix4scijaPYiyBngRZm/7fTBM6PrbzHTGornFahTq3MRi8U2JN9gEUls5vWnE
	 gvkIdULQyvRKWYSYIBzDdME+WK9rjxlep+JynZwi3RX+OEqAVBTVZIh+TCSECJFjDrF3d
	 bGGmvxZlaFF9AdOsbO4/lWS6C9oondmjy2djt8vpozuWDCKZ1mPVCObq9ZBmSh89lzDmU
	 vAwXvNfsWhNsZD2q99JiJVHgEEtPsQf3/gV4Obds7JLYMYr9xK/eDBxIEaQMNOt5vFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=b7AojsWQdmnu8z7CsRmtwQ/iZVkZjTk5+I2/AfHY1s0=;
	b=woWr6DfnpLhNwDW5aiZsWi95TqZNsCLdBWzKCmAzMyF4gWxd6ETzyw9KAmPz/3YY2/e0
	 g9W7c16txOj4uLLmUiZLatVjHz8kD0YQDOYSSJID0tA3Nn/tqsDe+kjynhvwDqqQvQyn5
	 6UpQrnUM1lfxdS+9kWVzHvsxEk5lwfN6Amb31LY9NFmvT6MepryJOWD4IbpHlen5CSAY+
	 hfPnh82W1V13OymF0jjVcKWMwFgpmUUBQb4+xRcc0I5N8Ueran6eqT31bi5/UByjRNRJ6
	 Ab1AZi1gvGYvPP0rqDhg00Xedw4BzZSVZGeRVQBWwbma/yXAzb3CasE6SMD6eQCwn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZU30IxzG;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B7606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0B7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZU30IxzG
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9441591aa5cso124856585a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794502793; x=1795107593; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b7AojsWQdmnu8z7CsRmtwQ/iZVkZjTk5+I2/AfHY1s0=;
        b=ZU30IxzGF8dTAnKh0hg/WW7t2ylFe3MYJYBXubmCf1/k0kqtiBJ0BHFnlPIecHUaEU
         +IOyPQjcJanpVIfwQEyjiCo6R8ZX6eRq5qe/70rgSGI7XTTUsHeaJdEJ+rt86dO3O4QG
         IEUiGAj+qbzlD2oBfD0mzrQlpkwUxvBln1wYn9oA8cukVPeDq7dpLvSUXGYb6dXLyEFE
         vRplzbwFbfz1dfysSc4/vI7lT75Et/sbZuEzEjHfpQS+gx9dYciD/G51J8TE2ue/slis
         bnZQPk0+xQgbm/k2K/jwW5N5aOs1hrfOWqwRb16xam3/PsiW/U5odSFtLBlksi86RNx9
         J0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502793; x=1795107593;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7AojsWQdmnu8z7CsRmtwQ/iZVkZjTk5+I2/AfHY1s0=;
        b=2NUyoRFgtDQH/iMA6k9EoKQ3JJVVvbr8+7ICZxoPlyQfYzeRkSdJ2X3S9FV+TQsj/0
         tu4eYLZUm5PPR90kh3SicLFtkSkzD2mSrKzflSVCLBWWh+ZaFw8hbRLXuZCZnxxpF459
         lazPlrB5UYLkfUiCrH32dnUIeJH/KIsdEyb32XHG+cr6pRg4uGfbO720uuy2EuZVVNLL
         qaf9jFZ+XSzlOVX4iqHymfeQPhzssB3ZHt0Z+ELszJFzM5JYlWk0HRjw4qGgfWpb0E2S
         FMqf+h9NLSqRUg686EgCbEjEIbkOZbHtx8D2FbjP6+hOmol0xuRjJpWY7lvVJLYA6Ekw
         Cxnw==
X-Forwarded-Encrypted: i=1; AL+hErGUPZ6Np6h9qQ1zvw7ywR+wYkSZ8fRmXjIKYp6TuhMsWAHHoxDjvIqEApSH9vImFu10K7YnnuE+pLN8ODc/@vger.kernel.org
X-Gm-Message-State: APuU4Z9oKAhc37NhjQUEeuoKfJ/GCR5+eVPs3u0tfQeCJnK8oBMaMCzr
	peU6Zzqg447ruGrOQHhaUBfznBl6QshBYTEYsMLn8R4iiEMzGWBAIEQCiHTf0ODpXlk=
X-Gm-Gg: AYBFou2KrfFP7AFENxeipO3PajBkmMy7xIYmRD4d9qWZ53ssSexxRTeDEa5XmSFB7Yd
	+pzUojAJUDtVb0UA93prmMTV9XIZY34PwcIcvSiBWNkcqD0C/sGszagL/iRf7ESvu5GTrndheTN
	wuhDbsbaMqovSaT3XYxe88yfHp3YEO3WfXCo+eZIJVNxFa3ls4ysUs4MAlwulWYSd1KMtMeYLTE
	LSs/i1F84Plgiho7M4qAYpyAO/CLTuYlGs5HnohcRQpYiQeqx8o0xR7XM09vEMnJD5QrcKnBK9o
	CLg4PK5+s34Et+9D4EPrxZq45ydYaLh5nev6Bcgb9loeD8PXpD3OB7VWa8GDrAOhF4Ep5+uWrq9
	PwnazXanQLmeberUzCyA+FFvnFaSozsQkwxOme6Y7nLDzDB5cpZNjtP6K1jlMA+FZWFNNkvPD7V
	PTczF7TQZmW0NMTDXSSI0dfBJD9FyrCeSKxLheVZI9el6EucT8MtxkD6pjD3NaZw/3QZlb4zdeK
	pjyqb9J9e++7EuRb0W07Nf4NV0UIeiRjMETtYufyV1VfEDqrzzIUKuVeRQcspCwxK2u+B0b8eB7
	A86i8XeRtnR0TGVi3bg1MDtC277lkw2aXhrZydwoWbSbgc0WoKR3mJ2LPsnUvrdkH03quipjPBS
	qTnom3Kw=
X-Received: by 2002:a05:620a:6088:b0:945:f5c0:a630 with SMTP id af79cd13be357-94932e8795amr549937885a.40.1794502793241;
        Thu, 12 Nov 2026 08:59:53 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94935073633sm220651485a.37.2026.11.12.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:59:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 11:59:50 -0500
Message-Id: <179450279073.482102.1691484916250559829.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> The OOM killer can quickly trigger again after having selected a
> victim. That victim might not have freed its memory yet, but its mm will
> be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> 
> This can cause the OOM killer to kill an innocent process when the first
> might have freed enough memory to relieve the memory pressure.
> 
> Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> 
> Note that the task which calls mmput() might not be the victim - if it
> took a reference on the mm (e.g. ptrace), it may hold the last reference
> and release it when it calls mmput().
> 
> Therefore we cannot rely on current to tell whether the mm belongs to an
> OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> mark_oom_victim() sets on the victim's mm, and check that.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

I was able to reproduce/observe the unfreed batch and the second victim
issue.  In the base series i could kill a second victim with the
in-flight oom in about 26/512 attempts, and 0/512 attempts with this
patch.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

