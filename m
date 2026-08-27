Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C442F747A
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805683; cv=pass; b=Vxn+mfxx4ly6OYFSBnIiuaOuk80Ryooa9MV3VuaCiALjgAAamwPK5IcC4RumlmY7jN9keaMSHgCsbdMNBOwQg/0CWvXL6yVZufHwo4rCINAuWJ7FCh9pEnIhYhRDlnIEVjb9/kmrybG/zM3OAeIzW7zDkn1nEHGiXUCG7LfasFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805683; c=relaxed/simple;
	bh=wmJwsWhJWgGzixLWY98cQ4oV4zc1Rfe63lrHepreMXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyVcoxcPUi2slXdL43UwEWEuILAQJsS6sr+0EqBGVeB2h7cANMbxxEYubOu2BlTZcq+iHIllE1/z2XJBCgWTRuDVlV51IOWBHLjlmq9Mnw/fHZurCObyCePlbk2NvelkXGGx+NLv8EAdtc1HA7CRzcmmoop8J25is2MmIdUaiLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxRKqIAL; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxRKqIAL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38511175ad3so325362a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787805681; cv=none;
        d=google.com; s=arc-20260327;
        b=QA2pIjrD2nJOMDT2jrIAne4ZScCYZHmkYSKJ5+m8pplvhXOdxDxUyy6Fw7izCWyngn
         TINyuGN/Vm1/Flg0vseI7EPnWyS1Sv0qE5fDLpfTJGY12+DMRa3lSdD8gQFUWHJX+IoS
         U+oyGXhQb9T2DLoHM+BpW81+WWpBPg4keSGonRONmFV2ebvmZ6+1ibNCgCnvxNEPgC/Y
         FuGXsplxQwFTtQoKbUcldjONY7OyAokdVQG9fxQiVaMYrXtKdtYWCzxTxpuyGbjcRc4b
         Sv15ir1iHoy6Xuv5l38tbXLaXx8HsmImxJYJsqsWR74Qn6I6LGwSyl1h52mNorU3fsuv
         LuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wmJwsWhJWgGzixLWY98cQ4oV4zc1Rfe63lrHepreMXA=;
        fh=CFABQvtmZV8QHPtMy9hbTgIhOfLAem68eren7vqxcZk=;
        b=aYaMB92TLCB8JAcqzfrUk4YHBMr0DBepFCc8Z4XBvhF0X4UJ+fOM2HVmvSidsMYIwa
         4OYCjJ7i5GtqNzohSMMNVq13aT7GwGl4dEk56sOoToVC6KTu0LuvvufHSG8HwwsIIcEf
         JayQiSAFTK2d+odNCjWIQ5EUBFisSrymcK4y5KmG/lmrx8Aaldb5tMs0XkTpDrle9cLm
         733Db9WWCvCQ/ViucjRME9MN7owjbhjGvxYzbpSM65GIbv+RspoJJ3u8Pb8hF7kpsXqU
         4plUO/BeJ+t6cHe3G3HP4rcfnl8WqXpDZ6xCAOyi5VANkGpI4GkWsnc8n3swk9vz3kpH
         0cNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787805681; x=1788410481; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmJwsWhJWgGzixLWY98cQ4oV4zc1Rfe63lrHepreMXA=;
        b=PxRKqIALGDu1X5boEPBCMxLqob8BmVlSTuUfVUnhYJQLeuk3ACkAZV0XI+DQLk/BcQ
         V/MR3dtnaRyKvYWqa8PYw1luNTySzRvWMAweSszL8fnhtk7FsSeWnHAXQOBUbpJDDLD9
         U0lDUGWVFDKky90lHVFrvJiwmfEiD+zdLnwhRaPJMSoqhEGhVDy0V1ipew+9aCMwjqpy
         Ea8YaICxbSzDz6veNAnqb8vZh6AbNC0/9XESvh/p25Ducrjv9q3M70Ja+am8AIO7alRd
         gL/IMnSPLjvsSaGVZNa4d0KsVOVOt2xWpoBUtQB3D0KktNmuqCZI/eBsFOouL8Xkln81
         AgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787805681; x=1788410481;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wmJwsWhJWgGzixLWY98cQ4oV4zc1Rfe63lrHepreMXA=;
        b=mZCglOMklmmA9FwrHaflrmPbXOUDwaov6rYBFSM14HsY5d3O2GK8yyCxFz7BnG5P5l
         DfpFg1HRS4kzmfAsiPLyWcG38MUbSixZrQJsZRKVnnYokEzbkSyiXYwlWoQYsnrp8TcL
         H7SHgn9b/DQHAJI8C680F2hn5KDZ671YfNdAVwtWSypEyIVg15lHj0CiPPByAzWnHhQk
         vAYAoETou9qy+00S3x1tH8ddAxh7QS1PAsyFff4Bbip42bLm21rWwVt8t/JcJ3kZ2ctb
         su/TKMxSxu1uHDQaaP7zTu+oFNOa86Q3ij/TsQl3Gu3wzfULDBWk2xHabJ72Qqn4IgTc
         fmxg==
X-Forwarded-Encrypted: i=1; AHgh+RoV8u8/e7kbuzZ9krAcdRZuicfiOHzdaekLLrNbALzKY3zd6W2gCM6QFUoBt5EAe9Zn7vK0Jb0l+pEfO7DW@vger.kernel.org
X-Gm-Message-State: AFuF++mwaee/uX73m/RLI4wsYkuUdq18qlWGesP9fU+159M5nKcznefi
	QTKhJRdt35Ao88LTygBKq0DiKlqDDRxNcFzMFmgKvC8QeLhhbmtDeAPhK4CPTauq9GfKuzkMBB2
	MzXYoyjAEKcg2eqoVG2wBMFXrP4H6jXk=
X-Gm-Gg: AR+sD10RlxMQhJLkJo6CfnsmbicP6dHqzcd36Bg+3r4tU3ntOZCqNbZujXBCBuhKD5n
	Nd1E0AOLUwrcfRIRumpSzfj9b+aNwyu0v9jZRwsi/GiQvDf53l9XNQoIOlqHoggQm0RjEi2S8RP
	9vSUh7gbU1NRxm/G9QcNekEvso4ZQ+IqhzIlV6jy1VnJhPIhAJXwVYWH6rZH/1REYf5bmH/9NV+
	S3WSqdx1axRP9tyyF4imtfEgCBZ2+e1MAjrwVrEldIx7Ztic9OsH5OjisdyPNK37LUCc+GpjDdB
	shtnbL5mN2HZDNe22f/mgDL294pa4zHGEkmBYzOt1+IcZEh5DQ1L6l+TGIl5R5Uj+hd65C6p2lq
	+TEl7iq6VG+9kxRF6dbcwLOk7Y9N1MMZlxSVgeUb4s7RScZUqhGOYfKPV
X-Received: by 2002:a17:90b:384e:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-3966d4232fcmr23112080a91.13.1787805681332; Wed, 26 Aug 2026
 21:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826052055.19201-1-phucduc.bui@gmail.com> <r2rpiqlkgw33igh262cieoyoeqdv7vd3vh3swjasdf4vdjgyss@e2rrpfe24oub>
In-Reply-To: <r2rpiqlkgw33igh262cieoyoeqdv7vd3vh3swjasdf4vdjgyss@e2rrpfe24oub>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 27 Aug 2026 11:41:10 +0700
X-Gm-Features: AcwNN1WK9q1v3aiUsd6wEufY4owd9gQ2pQjo_-u6uW05Cc3kPxSZrk-cTDoPriU
Message-ID: <CAABR9nHVePW3YdYy-6j_pSPR3-V4t80vXYVx6S=K7dC_iNR_xQ@mail.gmail.com>
Subject: Re: [PATCH] chardev: check return value of kobject_set_name() in __register_chrdev()
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

Thank you for your review.

>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>

Best regards,
Phuc
