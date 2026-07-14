Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E743CEEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020929; cv=none; b=QWpuJd1XGBUleClBnAOcAwR/fiW3sbPJlho0BnyTD7JyrTQGVdD10QBG49FmSPbx36pZ+M2RaQVS0fTob43kIfb2f/u+8Ouo6pWyoZ+UvAf7m4Sr7Mh7oplUmWwHc9ctRhGorrhPsldn+gb3zwLbNdMPkDhXcI6YsmGV7F96n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020929; c=relaxed/simple;
	bh=W8OT6ovmAQkwBwCI5qoFSNzG+sz1ik3/qbazlMkp4fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOeFzbP+H3TZsLh/ACIlQmFj2LKjoj+N3RwUnlGNRpKnXUX2OJfN7ViS1ssYjpr/N9kvzrwC4MSTLTD/UfZgjcMHyq0Q5EFMS/rzj/Tj7EOu+/MNFTZieLP684lXrlNTtXjW2w+65guVa7nLwfW+TG94sWbaHcszjmeNsHWqg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlMpiiPu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlMpiiPu"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f365afc5aso1232960f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020926; x=1784625726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
        b=JlMpiiPuB/c2oZZrBc95DV5SlirlC+vI33zg0SPOc/HulQ6PRfzknxCCkoafPIpvrP
         /EJj/1KtO89mjrSwAg804DK5vh0COyxGNwuawFtnFZ7KMBigbh7Zzl57kK43Uc+sUCpE
         GCcqSMQeeV9CRff6mbMZEH7sAKA5t6q/8IcQVSdLwXCGd07VBWMpDWIVtj2UX6ZZVhsX
         0NgcdbBMpU5zzjkqiMRgF/+NQWG+NLTSjvp/R3LTfmwft2KTKXT4bD3XsaWvDLQ9qOGc
         i61iRKqNiiAd7ancftpI04EnANyP1jtq9AboinBkMGpTe2fYXFve0PE4fjxU28iAycwY
         oXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020926; x=1784625726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
        b=pKJSWfaBcLRoGAgTPha7UCB1ywT+ADzZQuuMKhcZy/4Lj/rN+LJ8Ro4lv74ym4uRNN
         P1ejHdAm65b4yRvGKqs7vchtjLaYxvx2UYEsUDG/Lsb+OjZMWXWazU4MJ/iB564pj1p9
         k4LtQxtjqhb41dQkoQHbfACFcAVp3bKH6Ksvfz8WwRXkI+vjh0eyHkuHNX95HQJpRo/u
         KllI6olh+XoKc53z3wLREyLlvHebghRxQG44f4Z7yE6ZmNoAYjQPbkzA4T4m1bjHgq+z
         XQs2mi0G1B5X2UJlZtQn5cqqIaNJOCmjcKzpnPr7hlGpkr3DbtZnxOJZZI2q52GTtUOI
         cIKw==
X-Forwarded-Encrypted: i=1; AHgh+Rrk1zG9doWojq8cBwC971BC2N1k8FI5zqjuQIbnW8dy5tvey64lQBDTvooOptljZXYVG0iSGAClnKZEGlJk@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSX6jfhWfT4YjH7ZfhKtXhxnXkwduxWZmchO6XiZuTUyNB0/U
	kUwWRrQshfi7AO9QYic2I/bAOBD8Vx7QsleJPpMr+TUo0uWlAowb6lFV
X-Gm-Gg: AfdE7cl5Y2JfZiOFy2bY7+C5NnrNl6icCRYlbW2rMDQCFCIJ1Z9euWuOaspYa6/aA/f
	ez5u+jkC2oV7Bbyl876In9totCpCeUMuJydbM6C7VO7k+8E8iPsbNJr/N+vYVHo6C6uLRVEco2e
	WF57QbKoV5Dh7CWs49Jsdua8s1v8es02Fn0cyLwp8z07CGXPAecf2SEYd66UEvLKrlvtbNHsN9p
	IKci1xK9APX+n0Du8y5TY0H7zWF9x0nUqxJ2tADzWW9NEu1yZ9YzxLVLywlkcQUZCIzmtvvTUIM
	hMnxmwYpYvd0bx9iZM1sdU8yDZit6x3VqhmI2myXY2+gYh7IfzXbgSpIdKHAQwi3C6M/WK5nCrj
	2qYeTKsGu9Bdm974jd2mP8QFjkerl+STBXBOQFL5V2WOcYYYNGJq9gYKceAyF3f7qEPJgzh7+/f
	Z7do2XA3z472CNI80Yv5A/sZBxyX1wYVB2DemwKxTjWZYgvd11JTBlkOSJMbaf4DmRX8MzY0/+7
	A60LcEvdgzmT8NOQ59dp079nw+TX4YjV06eSQ6QNru5pA==
X-Received: by 2002:adf:e186:0:b0:475:6c34:2120 with SMTP id ffacd0b85a97d-47f4887dd78mr2004457f8f.18.1784020926324;
        Tue, 14 Jul 2026 02:22:06 -0700 (PDT)
Received: from [192.168.0.207] (nat-wifi0.uniroma3.it. [193.204.167.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f476e9d02sm6291743f8f.19.2026.07.14.02.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 02:22:03 -0700 (PDT)
Message-ID: <619bb771-1038-4ec1-8d4c-17dc69df33d6@gmail.com>
Date: Tue, 14 Jul 2026 10:22:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20260713071828.GB30168@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260713071828.GB30168@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 7/13/26 08:18, Christoph Hellwig wrote:
> Hi Pavel,
> 
> do you plan to resend this series?  A lot of people are eagerly waiting
> for it to land.

Absolutely, I'm going to finish v4 next or hopefully this week.

-- 
Pavel Begunkov

