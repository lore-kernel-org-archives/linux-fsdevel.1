Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174292;
	b=Yp8W7ksPSKI40Ss9ZbdJ8j2hekShGWELjcKyH0FIIh6K6mhAqr5HPNLU30yXieAMEmqn
	 5t+RzVAUIEyINlZ73fpWwmJAtnBVEsX7t9+GJfOdu2IBImQAEXR2n5d4LMkJOSj/hGAA3
	 1VAOwbxehXnqJDsm0AHbACYaT8isCXy2He7dWSQEbY2WzcXhizn4OMUAcEoKBFfkpcyj5
	 kPyWlhMEqJA+eM5tEG0tdueqcbzb4abZq7Ju+XvtSkM3/TClBQ+yA/CulAjPqGbO9uSTk
	 iRmmtB4IQzcvBd4rcAzA0iDl/r3fBAd0duOClm3/BADuD1Chj8K+LewsBH6szX156Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174292;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FwBF50PIfL1aiRZV3XVfdxpCMikmYS/1IPOH4JT3geo=;
	b=MAsoodTSJNqrAPcJLPTZUosJCQ14FNU79kpdmQWG1uTcb8LDdm8Q4Sdmn0WohV+RUj7P
	 RA4pM0JYj/2XY+c3yNaLecHg3MSstjzahID7oiXgcjZHZjMxZSyF8XFD+1ocfQ0UoB4y3
	 aYlNXUAZpIbt0i7eqRfda3V0zZ0/cbrMO5uDW+eWg9wtUR9VUXclAoy3A04swRuZ+oHit
	 5gKvOswP44PHAFMAockGbaeB2jb/fL3eU9Gm5hzRk3z6fsXXGppSYBHpKWhQR40ZbnGD1
	 l8dbK8716mAu3lArvx3b089rARxuS51LW5IKUqE3fJUR94W8G4EwybVG8QupjbN/A+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyyiOHUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38160A2606;
	Fri, 20 Nov 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyyiOHUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D571F000C4;
	Fri, 20 Nov 2026 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174292;
	bh=FwBF50PIfL1aiRZV3XVfdxpCMikmYS/1IPOH4JT3geo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MyyiOHUZtdULT6DEcjeMicWbSGpBiRKITjueL55u88L8J78b70T/RQo7P1wtPigDw
	 W52ycUM2UqceFCn8pQNAOMWT2Enz82Yc754891ZYESvJL4oiXgNjphEbc1ozgz2fa4
	 iCKObl9lGx/8vAyzPfB7xwlkfbaKhiArJ1xwLeaJQWkUEWLxapLNiKrkLWOtj1nI3V
	 tN8k1QhbvvxtKjwQmfEJmi7j4lDYPCyqi3yljS9Pf1FFujsTHVvWVHaUrv3vxbA3Xe
	 6K6X4JZaAAKnu2hfIqnxQfcL22DS7yRS5L0XBO2BEaE0cRAbvRIfSERlEcPCfVMF0i
	 fudP2WVJ3SDBg==
Date: Fri, 20 Nov 2026 01:31:31 -1000
Message-ID: <93b68486e7a30fc0332eb8f78bec46ee@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jori Koolstra <jkoolstra@xs4all.nl>, Ian Kent <raven@themaw.net>, "T . J . Mercier" <tjmercier@google.com>, Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] kernfs: stop taking kernfs_iattr_rwsem for writing in mkdir/rmdir
In-Reply-To: <20261118220154.2965621-1-shakeel.butt@linux.dev>
References: <20261118220154.2965621-1-shakeel.butt@linux.dev>
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
Content-Transfer-Encoding: 7bit

On Wed, Nov 18, 2026 at 02:01:47PM -0800, Shakeel Butt wrote:
> In the Meta fleet, cgroup mkdir and rmdir can stall cgroup operations
> on the whole host.  They hold cgroup_mutex and kernfs_rwsem while they
> wait for kernfs_iattr_rwsem, which every path walk takes for reading,
> and they take it once or twice for every file of the cgroup.  systemd,
> clone3() into a cgroup, BPF queries and the OOM daemon all wait behind
> them.

For the series,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
