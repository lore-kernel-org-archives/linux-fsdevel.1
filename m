Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874788;
	b=SJJ6PtCEcB4fSQ5GPdKHzpOPq/DgcvdRaWQ8o7FGw8H2HtUd/3WEZBmn6PlOjR6qHaux
	 gy5zSbekP0pLPO3EcKqSmOgVMBX4zOTqMk9QklM3P7luIaI7LGMsh3i24+yc5dRecVCW5
	 B0MWJU4JytbMCe7azOkSX2YuMNEBu8YFA6RcJ6DfTOUg0JyBrKUoWhi9U83qebW/kN1ja
	 W3I4jltLASIBrq1sNYf0/AcUZSS1q/HPZqbkpQLTFopNYgLpqSEJ1GY0sapereFaOsobQ
	 t5/iUWVMIb3nKsKdbZ0pT8ejcFYUNkq93USuPh+OPEJCn4Gp2yJXP/VM04yCQCHoPVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=v3H54DsDzOYnj3Smze3+HlsIoq0mUB1s2ye+/e1WTeE=;
	b=rRnbZYi4xFjTtOvwRkWb5vyTiPs9Wd+ps0eRn5fIN1RpKfQHBnzHBNy4KtRsCHP1zDpB
	 1bnuNpu3ZhpZShqU6GS3wIEgFauiUK9iHt98twBfFJxTxduzAn0+uDXNQPatyKNPjN4co
	 2WZnrlXnvXloclsmYEK9RkrBFIYCYqiZrz9JZiu8MRNniMY/hLA8r3aLC6gC7xyxMWMGk
	 e22yZfsJFGdlpKXNms8I3GqBiB5wqQTtUOwJxtCFM0g7iVsvu87duQEkxSDUyoXNEexNA
	 Im3/dvNhzNcAoVFt9JiFnP9EpAlNBug5YRC0ipeJpaGUZWwWlxtcD7Cw6vPgCIFdkKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJTWve60;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164DB606A321
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 14:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJTWve60
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5361e313e63so123621071cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874786; x=1796479586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3H54DsDzOYnj3Smze3+HlsIoq0mUB1s2ye+/e1WTeE=;
        b=PJTWve60gkjqokB9j9i26wjB02mdIzdtXwOjB6PqhfailjyAe7ApzPFiNVxkuKL8LM
         Xd3DlUZqP/CRIWTjXjIfZOR9lxYbyZ9U28ikqqoEOk49AIGBunNOaIMGw8pJkdA3UyYY
         /Mc8fLGHxGWQ6Db0Kv50pqepr4FqsFasBji5+4LeFgqxJpyAtK7OXyLeWPrdmrq5a4Ht
         2Iip9v8mvDbuHMq4M12V6lZ1otYb6YnXBdxsejz/y3VXMLWYST01SEWJP0HWIcGJT8pv
         KSHKmWY4PcFLAFUxpgthYnynHIh6mah6LZ4eJbaqsiTmg4L+ZrN8q6HZF0JaUh0B8MhO
         FLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874786; x=1796479586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v3H54DsDzOYnj3Smze3+HlsIoq0mUB1s2ye+/e1WTeE=;
        b=Qpfdfwij4+rBAZSj6AKVwsOAC5XkJQIRbZ/8jwLq4OzZDbmdhgOaLBJNf5vOGKyhbZ
         6i2Tv4+i6fD6KmkLMfOTFKBBaGGCfyJ4cqPHNNtIaEFM87uco1NtjxWR9Fn9oAC/62Es
         3zILXcu2LCPrUaWngWv0UMQBmwVUQGFuvALvjLGqmX54UDKfb48az9vVDiXnEdXuqMsv
         syNGWBj+B2F7a78KNV7GnBf18bttL6+rl+hQy5ch3VTDLEHtAcA+LNI50u9SBZqKAM7K
         YZ/zSHTZ4pCSWYYnPJaixjy9OaWN6CnrIJJ2ncfYlhTLHIIoFbXQ59WYlwS1wJmDIPNx
         aucw==
X-Gm-Message-State: APuU4Z+8SQzPihqFOhZGNKTHMZ81f4DIwYEWz7vY7gpFwthqwsD9yM8b
	KnfYMqvMUgKsxe1X8NGfmg67dGdy2OzHs5dNdidZ6ey6YFdvdXO4FpTY
X-Gm-Gg: AZFdTZcSBG3ST9oMFWLQDMcF47huyya2pCS+0zJY/uPf5NaHlLiMAb8J26ff/1QEgwy
	isuciw1gKYL1yBkG/nXTyRrc62EiwNXO8iMoBvdHm6CW3y1geMzOu5n0WI0l7cdzmOTCBpwUITm
	UE6OlhKQx+NHXRl3IctmQ+HkN3WAGgNWcf3X1A0VhsAxmMaXbSq1WeZysnrFs5iMwsbi+uhLNKp
	CfdwsSqBwpnw8+0Xg8bM+2ZFJESMjgNHN0swc8YiaFHxBGQEZtMq5sFReGAkRaW7S5Kf9hwpNnJ
	sGSutWgYeVX6pAAtdqrkS468r8gvL+1od7E17r0dhBIUiyYHlVxB/zmxBPBpRppnwBloKlqFPIO
	sSXU8+Ru+u9NHPBhizKqlUKD7BEj12yXoNr2AAft9hH/O5iOy4hjyjJf0HQgmzA1lZySHQ0CfeK
	UDKNxrng00TJWfL1UYPRPOSCQZJjy0JEOBKmPqFKhRAh/ZkviBDjzFr7IFt+nZA1ksP79tRXlai
	1Ai5vCFmJ4EnSR04IkcmJbrj2eKVcGHG9uFT1CyMsn8QfHuNR3EjtE9au+OEnHnxsoWaGZ8WIFH
	gJHiDR7QI4iaChuF2M6srdP74nCKGfJMxO9XT1KRf0Wy8eqdRpTst9Y8IWAageQBzP2i7igEK2j
	fEmNw
X-Received: by 2002:a05:622a:98a:b0:534:dcbb:4920 with SMTP id d75a77b69052e-55d76a19c9emr540008471cf.42.1795874785928;
        Sat, 28 Nov 2026 06:06:25 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm230475611cf.17.2026.11.28.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:25 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH 0/2] listns(): validate the reserved spare2 field
Date: Sat, 28 Nov 2026 17:06:21 +0300
Message-ID: <20261128140623.19-1-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
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

copy_ns_id_req() rejects a non-zero @spare but not @spare2, although
struct ns_id_req documents both as reserved.  Validate @spare2 the same
way, and extend the error-case selftest to cover it instead of only
@spare.

Nikolai Dokutovich (2):
  nstree: reject a non-zero spare2 in the listns() request
  selftests/namespaces: check that listns() rejects a non-zero spare2

 kernel/nstree.c                                  |  2 +-
 tools/testing/selftests/namespaces/listns_test.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

