Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757596;
	b=Ele2KmkSg+DV/SayuR6oooo9zKMHsCu6en13zVyXkzFmVDIPr+LsRq5LB5w6amFN/759
	 K4pAMvOeHywTGZAY4VdXVnMBF9/O2bcWXwIMYC9tXa43RqNzDF3F9XRIhnu/TjCQjGefz
	 A5rUSjN9rwjUF+AO1MZI5ge7jduR/QwV3v+POCVGpQWiIAU6wn4cRBNVPzwmgeCQpvjJd
	 fjx4+9jmtyDjk18Dvd8kZWPP2q2a1I/XR9GtLjrqocq7W/15XsqfrxfJFihwMlZYDJDq7
	 qYFEK+4MusfBwAc6yzfkw/k5QOsBTMSTfg9//wAhHyyF8dBmhr8rUUk2gsBumG11F5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9SSLJDkhxBZi21kj3K+IK+QTqg+ejmmv97gXCsdfGk8=;
	b=tgGMvh7pfQmZz28HPEw78ZziFaT9gbzGabwm+RmWPQT4j82UyaGwR+h1Nd71km7Z2neQ
	 tVGYhp9N9N00XW1Hz8FHyNT8/G1j7KCZFY9NvfET6DAWJzusFIoMt0d15M1R4XQV+0KuJ
	 ZvkWRjZgEw5hVZNh8wShSq4j/QkPCEwNXOuHJjh0wEbWdehUmAxJ5A5Lszx7MkWAdFKHt
	 LaBGSQcwguGtz0ZlQq9a9RFXMz9uQRjxf3HMXtgZ212+i38VB6qT4+njRJnyldIkHql2E
	 7EBUhpEx7MBXKrLzUeEaBvlPSEtWcQiwD7ebObtdip+spzgvthYysJZzh6lwE3R2mRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MLoN/EqR";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95E606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 05:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B95E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLoN/EqR
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so75848485e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 21:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795757594; x=1796362394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SSLJDkhxBZi21kj3K+IK+QTqg+ejmmv97gXCsdfGk8=;
        b=MLoN/EqRwHMu23duF2BjJaiM8H6girNIxtPhW8PvRoXWQvHIvc3lR55gc5yD51sjB0
         PF6s9XaTVdLma5z/zABtdSUQa1cN5Ugq43mz7Ay3uiNTTNYAxfLwaTXM/KCaUUsqCjt0
         v3NGJIruuatK8eXgMAH+Wjj5cMD2pzN2XduwVuTwQ+hW2p6+q7nYkfrAMY0Nb9KFXnnO
         7KWxvtkBHUJnrn0d25jp9C1hrmbHJ322F5OQjtGd+dRRhUQmC3zsjhDSY9GoUMEyovzz
         bY6fgClqEKAFAbOTGgOZCqTgwPn24I/37SPIIuBqZiwi5UZiQgVuSrIZrJPdtsZ4BJTS
         n9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795757594; x=1796362394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SSLJDkhxBZi21kj3K+IK+QTqg+ejmmv97gXCsdfGk8=;
        b=bb/9d74wpxwlbkqgdeMmRL/tW4v5Qcqe4GmfZcXrvxYcQqvmoIzoGHt9Skobp2ikm2
         5xKL6t2S3dD9RiE9+zD0e7kztp8OtsHCQFTyzH2mqCYOhX1nCPZkRwq6JdeJaw9Ot9vz
         5oS0B9tMxr1Q66XYm/kxUn908mzeNznkERelYKjbxlCmf6+JkQCThve8onCESdNhabMD
         dW7ZGPqJlH8brcQS8/8LbPwlaw6EiwFRyvW+2ftbw+k+SFVc5SxMeCOnaEb0rE6+N2pR
         1vTrFTfPRGsWH7vDuGZgNguuDjWV5LifTkL6u2CKHVI0E3B9+vcjYll7pxtgydvDVFYT
         9PEQ==
X-Forwarded-Encrypted: i=1; AL+hErFAbjFbfykb42FX/Am6r3GebC55lzAb2I2ZorrIVpJIvEkl5IxueEOZbyWzo6XYL4ttNedyyvbgGhjBn/mG@vger.kernel.org
X-Gm-Message-State: APuU4Z9bNS6jT8eKtTRer/Tox92BjXyrHRRlVsW6cz/g/YzD9QKXvfJ9
	0dw0yD4VbFqvWKUV+JwEnflK20oqiW5fyOjcoD0qeemb9fFamzo6x3m/
X-Gm-Gg: AZFdTZcgLKoGaBqf5CgZJce5Z5hUWOCPWof1xm+QgkI7Di3Z9Qgz1E4J6q2Xuynce8j
	unJOYhE2nfEqK8Ac6wpk3fDDMXfUcQpfFwPVif8oT30j7HwMtRj/CEzmRtom8PiyvVHI5n38Od6
	UItoJcl8PR7TJj0/Y+AxHQvCHg4guZtlKdat9M2tthu8vnC5lmFrbF47YYyCB/LqY5X47WEurah
	Sdfd0TCip9NcpGAyib6aHrC+EOg2rbZ/a1VsG3JnbV7RJeOQ5TbNQ/rMGlcXauHqL7k8frgMC8O
	Ej8NBtAyguYiuj1xnKrZOqLiRERpcMgO7ajrkwMy6SQR6BSs4Ej3hdAAhLq2wlbxJCx9mO324mF
	0nvW9L1U7eT/SKk1cvzHv7QbfO1gwW3oC5yyK5STGgVD4xUvG9v+rhLoW9TeW+Zjv/XxDG8XZpm
	ZHJAS5+Ue0Mmk5JPeCVCjfUrFa52HjO97wK/caV9nb5yw8fXyH3fw7bEgFUtso3O8AnKq3RfFWS
	eqfprrEw1YqDz8tagvQYHxaXO8UAQ5A1lM8frspWK9F16MudkqefoZSWHKwP2pRSPsGEhsA1dIj
	ynB2mdRSdXP6WRqX+FyqoDxKmw==
X-Received: by 2002:a05:600c:4f15:b0:4bb:6861:657d with SMTP id 5b1f17b1804b1-4bb88923954mr544645045e9.21.1795757594268;
        Thu, 26 Nov 2026 21:33:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b3a7sm735501395e9.3.2026.11.26.21.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 21:33:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: josef@toxicpanda.com
Cc: James.Bottomley@HansenPartnership.com,
	andrew@amutable.com,
	brauner@kernel.org,
	jbingham@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sergeh@kernel.org,
	taherafahimi@linux.microsoft.com
Subject: Re: [PATCH RFC v3 41/90] pidfd: add pidfd_configure()
Date: Fri, 27 Nov 2026 08:33:06 +0300
Message-ID: <20261127053306.3979858-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-b4-cells-v3-41-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-41-bc9095937a84@toxicpanda.com>
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

(I just found that waitid doesn't work with CLONE_AUTOREAP processes.
And exit code should be get using ioctl instead. My mistake, I am sorry.)

> +		.flags		= CLONE_VM | CLONE_UNTRACED | CLONE_AUTOREAP |
> +				  CLONE_INTO_CGROUP | CLONE_NNP | CLONE_CLEAR_SIGHAND,
> +		.fn		= embryo_main,
> +		.fn_arg		= e,
> +		.name		= "embryo",

Does this mean that string "embryo" is exposed to userspace? (I. e. "ps" output.)
Option is named PIDFD_EMPTY as opposed to PIDFD_EMBRYO, thus, I think
user-exposed task name should be "empty", too.



Also, I noticed that you reset all signals.
As well as I remember, all systemd services start by default with
SIGPIPE set to IGN. So, if you start a cell within systemd service,
then SIGPIPE will be set to DFL, which is probably unexpected.
I don't mean that this should be changed, just make sure to document this.


(I am not expert. So take everything I say with grain of salt.)


-- 
Askar Safin
