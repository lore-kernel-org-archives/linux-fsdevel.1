Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED648593C
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103616; cv=none; b=R6wbOJJ3hZE+57qhWGNqjQFbBC/ibkEdZRmatWF7LKn92g1GQ6zWh445nc/x7A71hTRHX1GK2kwCk0AJw8XFQXJrYRIK5Wl5QQz3XGj13N0VbMDwg7qidHPKRGb1bLOYuYErp8FqEihxZu4/HmLcyjQLtosp/z9Uxm0blTIU/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103616; c=relaxed/simple;
	bh=lwDc/4soCDTwvQjj3WdMQO97x7jDvcnzTKVIHsRmsDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiAc3IEr7AsQTrNTugHpJb49u6F9Lj6H+WQnQTqhrWyDFB9UoOkIPKw94P4m3M1vjvsRp1DZaiCGc4cqreg7TQ9sdZ5E9koqbJy4CmjPA2P9cZpacHvM6afiD7Dg1bULa+yUyCwX+g49SQtEnRjYrBl3VW4eraEujSPGZYlEXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+EmNE0m; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+EmNE0m"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so771115e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790103612; x=1790708412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VEpKCI2OAMvJmBnkvfe9WlT81W7n7zUyoGhbmIGEDGM=;
        b=c+EmNE0mpDQJ4eQlQ3ZGiNyv7YTSwhfNQurSkejNkS44k+pXfE0klYjsX7RzZrkJic
         c6oX1x6oMQIn7dUBf4VpoNGj4PQ6oXwuPjkwam+Dvy4U2IrjfEWd8NQga/SGelPQXKEk
         2Lt7KPGaJjqktxVLLTMm1tlWhgHAm4mFp/hSjJnDpRQVZDxugIJ0PRn1wBfEsB7NZmpv
         sNUsQNi0B/RFVWwtmcRIslHs35nPDp60e8MGMHQYfgYWhnmRzs/t/EO5q94T4FbjEFN0
         HJDmMpq5qCPmrDSk31mRCfAfEW+ioHwkk+wPLaNqtOfqSH0/Zjr4TCBo2HdhN7Udw6lR
         trKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790103612; x=1790708412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEpKCI2OAMvJmBnkvfe9WlT81W7n7zUyoGhbmIGEDGM=;
        b=jOoFRNDUrsTJSuI8mGTQAnPC6PSW5QTL/CW12EyrkNiBpuEMErbXodjNmQtClqwJQ2
         fVxTES6r7ZtD9F0uM6rnH5yxwfg28HvkUTjZxNpIwyX+SubVJpU8zPng1io7AY4Wo2gL
         uc4XRS5x6L5BzOhuRJEUrzEdIA+1XYWf3fWEWjc8h3Vr6m7DAo1iXBRt3MgHMDqLHKL3
         tlW/K9+bd3teFvUJ7dWwklPgg9sJjwinycX0/svDJ1YZ0E/0M2YWsuifYP14sBIisrjs
         BrXcra24BAsqigu4kC5XRyoYdW+wxIOk6qyEitTJ0/nKnoYvtyJcBeKl1rzyNx+X1gPN
         as7g==
X-Forwarded-Encrypted: i=1; AKwUvBwER7bcqm5Sbhzu6XVvK3uA9zMA366G8whryesRBGb6VRZovf6JDfnTNXo8c++TA7KFRQ6joJTaCDWYiWFs@vger.kernel.org
X-Gm-Message-State: AFuF++mnDFWWntl1gh6/3aZtGch8CzUXvc3z1Xfcb+eTRvvWQcjVwIwd
	kFQg2kTyenH5tb+6Riw5En6HLc3ervIcrNBKZYcr2de5DqwIlaIl7s/q
X-Gm-Gg: AYBFou1VdRHYg3CgXBqyWvM+GuqBahRnnnf9Ca9PMpLGqa9kAfVgpBr2+10XNC0XVQ3
	DM5XNc9f7L+WxrqFscUMPw+wq4x/koZ0E8httBGYT0El/7nR7w8x/b/q78Ux/CNQgFYGPMwFMNf
	Go5yhy9C6+4nVzhIvsLdBipVvTigJRwQkO+0Xo2B5mLoTqoL/A9s2N7hxd905kuZiMgOxm0LkTE
	QCEqkJIcf1kJRty8dAY9CRZDf3vuvPfInwzxSllc8km20cRzVj9a/wLYFme2ho56baMeQ0oom+S
	Q/peDvQMzg9KOxmrNu6yd2+9biVvczolFf58cMVSYmBhPA6yblNgri/5ehu9fuAJgb8qaSKVlmU
	jr5lVCW5pnH48rVCpwXOVoWuSW5V+HleHEb24gBURgMWX4faEQA4aaevFu2BqQFaP2SblaxVFCk
	IVtdAztJHqsrlfYYDTQqhX5nUSSM0ai4v984TVxx80pVGBiLL6d7scJ1eHUGLWwwwm3WjrOO4Pk
	UlOg1ooDVh2haJvUMsl5gT1rf8uHlXaevwlF9H4D3OI4V4=
X-Received: by 2002:a05:600c:6297:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49fdf12ba37mr1731935e9.20.1790103612057;
        Tue, 22 Sep 2026 12:00:12 -0700 (PDT)
Received: from andreayoga.localdomain ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c48esm418281f8f.20.2026.09.22.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:00:11 -0700 (PDT)
Date: Tue, 22 Sep 2026 21:00:08 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iomap: don't resubmit an ioend after
 ->writeback_submit() failed
Message-ID: <arLQFnituIhphayt@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-2-parri.andrea@gmail.com>
 <arITIy2upsoN-DlW@infradead.org>
 <arJETViXYZbX8ckp@andreayoga.localdomain>
 <arJ0qe1KZoIaRCQk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJ0qe1KZoIaRCQk@infradead.org>

> Can you add an errortag in fs/xfs/libxfs/xfs_errortag.h to inject
> such an error and write an xfstest that uses it?

Looking into it.  Running a few more local iterations both w/ and w/o my
fix, the plan is to include the errortag patch in v2 of this series.

Thanks!
  Andrea

