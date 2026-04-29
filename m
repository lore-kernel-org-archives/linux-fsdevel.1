Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99323175A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420827; cv=none; b=mYFMX1B7cUU1Iao6KxddNe5MgG/dZTVgVH7PjZtWi6B70oPT48fStDfDt2XCdzjlcxKYtVzu4bz9SWrvCmPNb9145yy7jnHRM6AQSoITGxTpAtb6Zo2/v1qKCyV4VTDtG1HtV9dMJ8oTNHbykQ7JuRg2FQjgMBSMCM2aIf3gEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420827; c=relaxed/simple;
	bh=hM/bjbjhv+YWxdis7J7z05w7xoc3hP28qvSLaFrSXbY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=b3E6dHBJM8N80dYUU35dBm4+8YgXswq7qzGIbN5G4HwvdL3XpEvaDRyY8FY+br01O91KdvmewOqjehtRd+YoGyX5u1kDXHtFFT2tyHwgMHM4bR2m9EB5IZYd3pbnduULtzbd+oQfgrUT2scA35DGOk3DeEHx5x7kn6oOz+2u3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 72D891D459;
	Wed, 29 Apr 2026 00:00:24 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 2dByCRhK8WlwWwUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 29 Apr 2026 00:00:24 +0000
Message-ID: <c6c4e93a-83c3-4a07-ace4-6262cdc0542b@dev.snart.me>
Date: Wed, 29 Apr 2026 09:00:20 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Host exfatprogs repo on git.kernel.org?
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello maintainers,

After the recent Github incident, it came to my attention that the
critial companion of exfat fs, exfatprogs, is only hosted on Github. I'd
like to voice my opinion that the repo also has to be hosted elsewhere,
preferably on git.kernel.org like the other fs util projects.

I don't think it really has to be git.kernel.org, as long as the main
one(Github repo) and the secondary repos are synced simultaneously.

Sorry if it's already hosted elsewhere other than Github.

Regards,
Davo
