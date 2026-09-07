Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930450EBF8
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795835; cv=none; b=Pujqr5TM9FCdCjlWbl5YK15TKpsMoapkJHMWkSMpyRa5fG+ueGSIob1WEf7Zo6m1IaPCAvo8vZxQgyVlQ9v41HCahLhFpQpg8BqSy+IqJokvJDzb+qfL6yGwB5+fpcj/GYzTG24QWDHf7Wb0BiOv0n9wzOPLbhQ5LfPDxlcySmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795835; c=relaxed/simple;
	bh=CJsX7WqNwIl8xka2b9C1MLEX7MPjxesh8mktt0eOQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U40FTpHiFJ4GT0KYFmFJ2jUmsKcKSNCCcJFvMxFbQoLMO9ukbR03c8T9dJrmi9V/Ewwqn4KhWVkHR8VenIZdrxbI0KVdaupH1I5Kcfg3OjXCTWAYkNSFTuNjR9+2UIDiHObguaJ9MSS+YdwWFbcImoUFox4t6Q3UfTiWDMkBD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VGljGjQp; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VGljGjQp"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe528e9so1054436d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795830; x=1789400630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87Eb9cn0gqF/vxYu718MPm0f1YFf09SOKLR2T0rK7Rg=;
        b=VGljGjQpYsCwidgu0HJPuqnfN0T37V1FyO5ZPQ5b3UOBsBQwsPOlawZs9u/eXrpv75
         1kMqeNbFPxr0/m/io6bcWPZek6rRy6kkqtGvsJDkrMxialSziNmtxv+dJNtynH5Qdbta
         mRhmrkP7c3B7vuC+/LTqnj073PZEFQAK75A/dIhi4fcNCtOc1F8tX+927pj2CyCEGkR1
         CQGiU7B0KlCz1azTO4klTUzE33dskWbGdy/tXGjCGf0keZ7rCcdNEYN0F4c1WQNEVgyb
         JFrYoT3MpwMfGGfwNdeQeNRuwsQbe4V9Qj4MqxzaseegI/FJnQs+i/Kdf7Y0oPFhL2w8
         S/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795830; x=1789400630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87Eb9cn0gqF/vxYu718MPm0f1YFf09SOKLR2T0rK7Rg=;
        b=pS23RQs1uVFrLtAaVRrj0sP2kxoYmTy1YUSyLDurIXtH/W3mwlt++nmkbQe6jJkEeR
         RxVC+hUt89lx4O+/k+r982TLbe2+YYFxZxJmb9TzO7B5E+65R3JtWOugCAcXKg/nk/CV
         QESlK822UbPpocSIOsSsnzcxxCDYJ2x7JK/GlK7DFeO2krhlS1+l+xBM1STQ1vGU7NMU
         2yox76jBNA6DG6w8HQWTnLaSz8PgcTN/hTZoMUaqITUa3Zrh62Bf3kT5DrONvCUQg8NX
         1tInZYQfzP3W46yZUeeeW18lpQ5fWuD5yRiehW7pC+hRu0FOCd3CCQVEHFgtTle6NfBI
         9ntw==
X-Forwarded-Encrypted: i=1; AKwUvBzrUTx8PL57kWuxeKjQI/UgGElpn91m0fobUi7xjK2a6uUbO6KejqE49FLzejeET/6KdOxd/giGR8IdC7WV@vger.kernel.org
X-Gm-Message-State: AFuF++kMfJss03LKZGoYyX9uI9Qfk1Y1FTTj/RLvPQhGkqA8pMR2R6nZ
	Gq6iVUBWckNU/D/0xtbz3U85+JQsdak9lSOsRHBOz5ilB7/T8IRj8WPIlmgXAy9LD/o=
X-Gm-Gg: AYBFou1gm8DdP8KU/6zH/tD/1fHTHy0lklp9AHntvKJk5bokBEgRA7sr98o3O2pXodA
	LfNALLxiKb00eCQbLzAGCANENWJhnhfsyTZadw4h7fx21/J+kEmqr6yszEkN7bNVo9XDrqqu8Zj
	y9vKzlxr49MidBnllKjMWgEVGJgdjjnNnGB2+W/AkkGYJ/meG+LRk3ALPgFC1G0l/ZkTqKz6egP
	LhcLoRAXN8gNC05HdTX34knXEOBxLyAOwzlGe1xs8q8DtjV8uKb5+r0yffu0tNH9q4rPXTaj1tw
	orQpk1E9YgxINPfshyxynK9JNNA8rHLaVRw5g3cYZbCCn6L+0d2ovOhvD9jByuI2FYir+vvL8vD
	YJofWMJXkp/XGBufFfkYjuUb2EW7fHzhRBHdAyxmvM+Ryb4E3630+/eAD1j5D0Y0dz/x4WrgpG1
	k+NrX11iQYDrNlUUKfAC27GRXD6RkgZNEc+V/8xyKiwfDxTn8XM6LaJIf7EuSykMRLSQSS6Es3u
	xlHRX7TfnkWKCHu5pJSpPBfABT7HN8RSxgaVfVm0SOwcA==
X-Received: by 2002:a05:6214:2b85:b0:90e:9ddb:1224 with SMTP id 6a1803df08f44-91061f709e8mr21563666d6.4.1788795830418;
        Mon, 07 Sep 2026 08:43:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d59sm93755486d6.8.2026.09.07.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:43:50 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:43:47 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, tglx@kernel.org, 
	david@kernel.org, nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com, 
	ljs@kernel.org, sj@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 4/8] mm/memory-failure: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7bqPro90Mg270u@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-5-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-5-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:30PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() loop in mm/memory-failure.c with
> for_each_process_rculock(), which scopes the RCU read lock to the
> loop body via scoped_guard(rcu).
> 
> In collect_procs_file(), the page_pgoff() call now falls outside the
> RCU read-side critical section.  This is safe because page_pgoff()
> only reads folio->index and does not traverse any RCU-protected
> structures.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

