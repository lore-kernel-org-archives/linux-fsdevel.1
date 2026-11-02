Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659771;
	b=RNpw/cnFQ249Kjf9Y5uMBGPgn6MnhVRqK8j5ZeX4Reht8S6dFPcZQHkb+HGXdK3n+mM3
	 eqZuD/a3OqRpadDop3oh6TT24RcUbGPmKf5hlWbhm1r+pHgyjQpT+QmNfh3KnKsVlqP+O
	 xVOcJFtbRLHFDu9Rn3EtuUyDA0CfnO79bNtiR1ur/JrUqgNEISAAry2SZW1KYc83/LJ7Z
	 EYb45X100AUM/H4m2HyA8Ri+5AXiyRFAIKRYLNdeZC5VHT9Mb2R5I4XnNM6jcijOzL3WR
	 yAGs78KjDimjKE03bWwJFOc779cgpyr9HCS++/luGChX9k6hhy4FZjRdY9oGQZZ3JRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=xPVIOrJME2+FRmlVa4Ph+81dFFJXHKxCy7RK0PFxH3U=;
	b=LS28xe05cESujzXxQn0EEJ2vVnHeC9j8fYFRgSeYvLV6ZjhKAs2Wxg7kyR2JfmiyRT10
	 HwyMGFDLvyKOcrPsxTb1RIKOlp6cZtsAEJM8EZGueyxRrMyp4Bw0xaIZMFzJIcfM8OxgB
	 nHqPJjPxvA9IPMSOwq/Ya8D1hYnpbXqDTVn/WpvskxYcGi7wExshU3n0D1gAiVftna71w
	 5aeaLuDm3gd4oJgZeUjTqVB6gl05tpPfHavS79FnNoPE9UezdWrp7JH7VdsaGY0hbZgtD
	 NvQnahGOIvVdhrM4WTdh8KR2kM0qYVDhlmHKS/YcQmNZm8GsXfPdO4suhTeP6kKci3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVfnC7Sb;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E2606A335
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631E2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVfnC7Sb
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1404102a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659770; x=1794264570; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPVIOrJME2+FRmlVa4Ph+81dFFJXHKxCy7RK0PFxH3U=;
        b=ZVfnC7Sb4eNB8b65r2Hc2izQ+1dDwA0kPYADjv5ttcWGWLqrvarH0Ymb/PlTJf74fE
         Tz4jCUP8Enu5fId0TgsCN0U0VdOgrk+9gX0nprDvgY0y5Ms61VebCt3oh+i2yjv4qy9n
         XhpjrMz8VKeruwhJyCGjrSLisgFLdkRNleLHoDlEVHmyxegqVkQb3VAo16C722Zf4C5O
         scIq4uv5FaL34ODyjof1rZF4+uZGJxNOfdpfGB/2II1g3Db+Ns5KeIyb3LJHueBsNqDL
         PNWqM8TNPlFjC/MHqJteED8+LCyQ6P3m4Bd3At9lQSK4NVcRExQywUHX31IZjSjXEBXe
         D8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659770; x=1794264570;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPVIOrJME2+FRmlVa4Ph+81dFFJXHKxCy7RK0PFxH3U=;
        b=wpKw5VjL6qI1RenkhiYvVZMJsEc0BOD0rBIBHEMo7I3LBmzISomN8e5xVzu14MK7p/
         onm09F1DT4G4ESoNjKG5dcYFwg7mxEvXEiYt/2rrognneYQKpnafP1t/K7Il9MVX308m
         2i2Nymm6sII2llFjwZrgqXkqZcbfrnG7bBIv90srBc0X5MAsay6CeDXRLmzxlJfOvy1I
         GVnq21CMYM0YvvQBmxohooA3CMexvgr/1I59IidaGHAMSSluCDORee1SYBfgKtYCWgbb
         IImwSm1saS2azr7NQ4iznGIT0V8AEzxVwYISo2lELpZ4E21hgUgEKcO7a7soL8eigA6v
         xbAw==
X-Forwarded-Encrypted: i=1; AKwUvBwHJK0v13UyhTrhp2VVCcDc7zmPBWVo5eSM8Gg62IqwHY/5ZJ7lFftFViI/gNn/0c1fAD5L19IL+bWHQjjf@vger.kernel.org
X-Gm-Message-State: APuU4Z8WHy2PMkZevpccd2ibAoZmQdciYFByj02k0t8VPR2CKFaMWXV9
	DF1ai3H1dhDv/JfQeweSPT+WY/bJL/ZnZXMk2DxVxQvBS9QfDSUz+zX90pO7JQ==
X-Gm-Gg: AYBFou36PD7TaYPvZFmkVP4LSlnigwHf8PQ3/Qb0phbW3FjI/RwYhyjNYLhf3ut5uZo
	P7f+3DrgKYFsJhjnDLenkFt/CR+3LRWZXTKyrZp9EOlruOxkksGhuIkTjk3tWGcOzKW/iBZg5hy
	7iXPlxWFkklJhwv7kkM3wLwEkkLRL2SPUzoyA+aAm/K9qFQx5kmfoDs1ReBdVyxUKzlsUjIdj1W
	FX0pit2sJ8MMhlgrqxWQQzIFfHRvoh01D6WuM0HRIr0G55p37m3UQct5dXgjWC7+I9wBcES0mvx
	RU4Bf2tFRkEblQd5zyH2woJ4Z4PhdfLAkbkQ+H4SnwAI+SjYw4rOdL0O45t//aVR2Y9PbjaEduO
	TfbcYhwtC4KgIB35DsHeWjOqRVlL2sIDq3zduTG1XIq4Y6qMQSsE+ZHhVB2BCWX8aXQY6Biov82
	J1G1mk+SEW9aCfaZlFdkChxnBerUQiVNZDNhJY7uWqkXy4ai2gtQrE8MqOSDo/Qxvib+Tdjhg6i
	7Lsjn5ECxSBS6nMbPAHL00SR7lRUw/aEKvvG9ZDLI7fBgBQ7XOunukzfczuuIK5+3oZ9Kz7AOqQ
	Z31KVDIolkGbAIG97ArYmfqObMWITd313iaYJ8syzyfYR03OZ/AvuhmztDa1n6FigwUuLCS6TcD
	feqRBFxHkzERvCiHe3AoeA0cr3xOg+DBmWw==
X-Received: by 2002:a17:90b:57c5:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3ae89282d02mr9413027a91.0.1793659769481;
        Mon, 02 Nov 2026 14:49:29 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c583d0asm1128204a91.3.2026.11.02.14.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:49:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:49:28 +0000
Message-Id: <DML3BMBE94PG.3UVPO48U5LTPZ@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <viro@zeniv.linux.org.uk>, <jack@suse.cz>
Subject: Re: [PATCH vfs-7.5.bpf v2 0/3] bpf: Add bpf_path_getattr()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>,
 <brauner@kernel.org>
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 02:46 AM Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:
> Changes in v2:
> - Use a thin vfs_getattr_nosec() wrapper returning struct kstat. (Alexei)
> - Remove struct bpf_file_stat. (Alexei)
> - Update the documentation and tests.
> - Rebase onto vfs-7.5.bpf for merging through the VFS tree. (Daniel)

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>
