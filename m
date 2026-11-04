Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758873;
	b=hqNLIn0jJ0iGNLgQW6v6y+SAD/2c3e94gUsawMEXKpuNTB3pjCBSAC+DvC7ttjo6MZmd
	 Bu3xrAEDruSMknmuasmYlNrQyCNj3Z1bFF3i6fyOgzvCqVFaavoIsskDoC+dmldyyUuU4
	 eu/uHlWnMwJPyFjEQUiEfiYR7xHY4GXRrhQLD3D48HzTVlAop+O0VPskhh/0vE5v02vgn
	 vZf3ws4m69JiO0Deq3fNcxCOwiiDtcmLDW9x9pbTlV5G+ZBETzAKYsegcY2doAc7WnY/c
	 EjDpWC/8S6nrw1FaiUllvdMAcdzYVT4EN9DUM01TQkbOUJrLwAp/HKFFm+PiDMXmfWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zZTUjENcLwaNaxc7QvvATziTGbi5drNO90koPPjECGM=;
	b=H/rjMWdASqUXOLMwo78iD5c0MqI/3akgcCUqQ0gvCpLyV90aSlU+c7IjNEQ0yLNZemWY
	 Ouut11bcXGW0E4KImpjMHb1WpV4csuDvczKw7TLyxwIvUvSQjIFLGAOJU2c7H6rqRtn46
	 RiEHz28eh8yeZOCZv90vBNfouiGuDColhVOg/4eZo0Rj8HkT89eAhFv+aXbqKq5KvTgNz
	 IlhTn3cAAzLKssp1hueZ0BZ/KfURH084LK5DDvMUM+s1BHya1LfOn6B/WRZB/7isR99qi
	 aN9KfQZPIZlX0hpYcErAtBfNNP+4cLMq6ubx2pZFnboKHAoEngVy7CYXv0wHBpA5zQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJEZanc6;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775B606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 02:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1775B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJEZanc6
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b244fb7fffso370026c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 18:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758872; x=1794363672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZTUjENcLwaNaxc7QvvATziTGbi5drNO90koPPjECGM=;
        b=DJEZanc6zshUJbakA4ha6enlqCMX2HUKDZDDkOzb7dNOQo4du6cgyboLh3+DMEQiYH
         Tt9z25oCaBB1vTfcVHxeopv/W5MMVwzY58sMZRl3rYBNFe1wucQSBWsPxzAIX6IBC+w7
         FbwyiekbZUxayUaKyPPlXDEK2XecjysJhxzu3k/6S2KZD13RcSFSwE50qnQf9WMLVbaS
         0UXW7MVxlOUPy9uNY0q15iwYYY+13tMoFFLAay9dl/r7S/DPBM+FFsbm3cpSAzsUMlSH
         4zFcpYXLQqsK/DfbmDgGEUATDj4iZGNe5qlVYvoAJzS3EQ7B5YdA4FZrPg5yHKjkS+kI
         VVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758872; x=1794363672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zZTUjENcLwaNaxc7QvvATziTGbi5drNO90koPPjECGM=;
        b=HjBIcVVSU3FUrKzMSbJ7Yz1hWdZc5lV9fAIQcQtUX4JtKl1moWhkOC9Ku/OLT8IYrj
         iVMapuf2QwzWAk2y41l4dLwu3XbxCBzxOgRhWiM7633eSTDdpRQQpuyXSFlQ+7Anhd+X
         lNQck5BGgZbarb3ySRmi8vom/xe9SdWezGdhgr4XKmGywQI9J1gfyYiRpbt+r1rCYB0o
         91PNWQWm7TOE49ZtZlGQ5UIlW1+Rl/q7YJS1zB6rwtVt+f2jLs7UuuZC3BVTO0BJAUUG
         BsbpyYoJ6B+hSMJ4NMh8JO5c9OJsddQpLhumTeyL/4DU5MGz7UdOskncFf+j1EMNudN7
         MyBw==
X-Gm-Message-State: APuU4Z/vAddLn1PHFbLD1GrTs0ngTzTGXR6LXNcB7bwBbVCSUw7ErU+y
	7qnWdC49L2Q51oMYEWbhD7VoW0QwD8XrZqyMUJjh2pHM2NF+RC1jIBsn
X-Gm-Gg: AYBFou1vhsAmgz1qeLZnc7vcvMgGqdetmXyrBBKVfYfLWe3Oq5DR/g81nFXgn3UvM5C
	WJk3xhxr2OwKucTPlr1/w6OTgPKcL9Np3UyijlYU+b58m+MW7lOPA/Pc2h3SqS9kuEdkLVihECR
	9DgKSBx1Ya2kxrJeRyvccnsxZ8AYkdHfSumcPQySYGpKmQVTHyZ5CDDhuLkRfXY5n7CxqAadxC0
	jZo+PjWE5aPDf4uqTI6ob2U+15R+X0A48J7bCSK7qzPg5vxoWh3GjCIem+zaCUuTQmMDQleX6F+
	C65/shHbCtQvBN5Q6UDAbzU5DRDpwJreuwkS6VcLKeDTnlgh5FPWg0vWFpkvMoHgVSVmG1HbWaE
	qSbFyrnRPo7IwFeqlGxH4WQ+EsFIM6ZpKZonXqpONoF6ZOmtomy0P2a9Lo1kLCTeHO5I4eZmy8z
	ff0n2u00hDC/HCjod29uluQCD1Jum2204PJN9gs0KjKDYZQxYOoCIz1o88YHvq2/Qb1aU1dhbNr
	y9hW38aYhsCFChGDoX7W0bW6yV6PDl8ZIGVdzKjh8lC48PqxPWPH0nqj1VKRDEQ/pvgYT+jNZtw
	zlxbzlngprd/8y5sxl+SVItg/MMata3+ni11MUQtD0lxzXVPsqyOIpN6DZBMBEpoWA==
X-Received: by 2002:a05:701b:4509:20b0:1a3:9936:d11e with SMTP id a92af1059eb24-1ac5e6007a2mr21183680c88.41.1793758872002;
        Tue, 03 Nov 2026 18:21:12 -0800 (PST)
Received: from localhost.localdomain ([61.255.248.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm2723575eec.4.2026.11.03.18.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:21:11 -0800 (PST)
From: Song jeonghak <thdwjdgkr123@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] hfsplus: free failed b-tree nodes in hfs_bnode_put()
Date: Wed,  4 Nov 2026 11:18:42 +0900
Message-ID: <20261104021842.18650-1-thdwjdgkr123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c05f958a83de97e38c2e54bb67ba3478ffd471e1.camel@dubeyko.com>
References: <c05f958a83de97e38c2e54bb67ba3478ffd471e1.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

> I've accepted this patchset [1] recently with some modifications on my
> side. I assume that it has fixed the issue already. Am I wrong?

You are right, it fixes the issue. I missed that patchset: it was not
sent to syzbot, so it is not listed on the syzbot page, and that was
where I looked for earlier fixes. Sorry for the noise.

To be sure, I applied ed8b389cf5e1 ("hfsplus: fix B-tree node leak on
hfs_btree_open() error path") from your for-next branch on top of
next-20261023 and ran the syzbot C reproducer in QEMU (x86_64, kmemleak):

  next-20261023:               leak reported in 1 of 1 runs
  next-20261023 + ed8b389cf5e1: no leak in 3 of 3 runs, two of which
                               ran with slub_debug=FZPU

Please drop my patch.

That commit has no Reported-by or Closes tag, so syzbot will keep this
report open. If you can still amend it, could you add these?

  Reported-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
  Closes: https://syzkaller.appspot.com/bug?extid=98547b0428b6a6a3467c

Otherwise I can send a "#syz fix:" command once the commit is in
linux-next.

Tested-by: Song jeonghak <thdwjdgkr123@gmail.com>

Regards,
Song jeonghak
